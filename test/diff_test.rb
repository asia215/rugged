class PatchFromStringsTest < Rugged::SandboxedTestCase
  def test_from_strings_no_args
    patch = Rugged::Patch.from_strings()
    assert_equal 0, patch.size
    assert_equal "", patch.to_s
  end

  def test_from_strings_create_file
    patch = Rugged::Patch.from_strings(nil, "added\n")
    assert_equal 1, patch.size
    assert_equal <<-EOS, patch.to_s
diff --git a/file b/file
new file mode 100644
index 0000000..d5f7fc3
--- /dev/null
+++ b/file
@@ -0,0 +1 @@
+added
EOS
  end

  def test_from_strings_delete_file
    patch = Rugged::Patch.from_strings("deleted\n", nil)
    assert_equal 1, patch.size
    assert_equal <<-EOS, patch.to_s
diff --git a/file b/file
deleted file mode 100644
index 71779d2..0000000
--- a/file
+++ /dev/null
@@ -1 +0,0 @@
-deleted
EOS
  end

  def test_from_strings_without_paths
    patch = Rugged::Patch.from_strings("deleted\n", "added\n")
    assert_equal 1, patch.size
    assert_equal <<-EOS, patch.to_s
diff --git a/file b/file
index 71779d2..d5f7fc3 100644
--- a/file
+++ b/file
@@ -1 +1 @@
-deleted
+added
EOS
  end

  def test_from_strings_with_custom_paths
    patch = Rugged::Patch.from_strings("deleted\n", "added\n", old_path: "old", new_path: "new")
    assert_equal 1, patch.size
    assert_equal <<-EOS, patch.to_s
diff --git a/old b/new
index 71779d2..d5f7fc3 100644
--- a/old
+++ b/new
@@ -1 +1 @@
-deleted
+added
EOS
  end
end
