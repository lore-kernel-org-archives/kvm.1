Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009FC433E75;
	Wed,  5 Aug 2026 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927832; cv=none; b=juORHBQhlzMoUXsepsCsRt2LDFZLn99p6VoTM7uikv8GbIHR9iSCewooqQYc9bXfcY8YUiKJVNDo4vTR8J+fQk+nj+Rx0OyEtWfMPV7BRlkXhUhi4/yb3kc4Z64vQqaw2MFRLC3d/OHCCc+4xIhrPBFBHPrzRLac37kJHmzQgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927832; c=relaxed/simple;
	bh=cYgenNcI6DdbSIjRFFvZR8MMQhanxPuMNqdnDjZWzWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p27l7kvLntreeEuIhM4mkH7LJsU72GyYaViGzKbtrv+bT8JJuBIrqSAay/z7jzWN5/07evQc5gXJyMdGciaDfcg9KtpRPjrRRlXXrnP6tVqquZt2tqtpyiGvgw6f+X2ZQd3PCzfGVjQjyqEi8LK4Y4R0n/xdkzVDc65QXqMbhiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RXLhK71g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RXLhK71g"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3691220B716B;
	Wed,  5 Aug 2026 04:03:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3691220B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927810;
	bh=3beNJnH3+Za/7vunv7aa4Wf3uGZkjunoTVeLHc8NxAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXLhK71gbs3C9ukpuGxCrmPNCrdT9Drkv6I2VnKW28tZdy59zef3B8EZCQV54lf3K
	 CJfK7XZniWjRmtSJi1kydly4+Sh0Bfnb7OrB3K9owjhaNZnHm7gzpqMTL4tjPuCV9u
	 1ZmX+cJ8ljsglCPJVGb9c3enrrscvWhBKp5ZTDGM=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 10/42] allow the command line to be specified for kernels in other planes
Date: Wed,  5 Aug 2026 04:02:52 -0700
Message-ID: <20260805110324.25067-11-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 include/linux/vm_planes.h |  2 ++
 init/vm_planes.c          | 23 ++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/vm_planes.h b/include/linux/vm_planes.h
index 5850c9e0d097..bb06dcbcf0cb 100644
--- a/include/linux/vm_planes.h
+++ b/include/linux/vm_planes.h
@@ -8,6 +8,7 @@
 #ifdef CONFIG_VM_PLANES
 
 #define VM_PLANE_KERNEL_NAME_MAX	128
+#define VM_PLANE_CMDLINE_MAX		512
 
 enum vm_plane_kernel_format {
 	VM_PLANE_KFMT_RAW = 0,
@@ -21,6 +22,7 @@ struct vm_plane_config {
 	unsigned int vcpu_count;
 	unsigned int kernel_format;
 	char kernel[VM_PLANE_KERNEL_NAME_MAX];
+	char cmdline[VM_PLANE_CMDLINE_MAX];
 };
 
 void __init arch_init_vm_planes(void);
diff --git a/init/vm_planes.c b/init/vm_planes.c
index 6fac52af4b77..613daa161298 100644
--- a/init/vm_planes.c
+++ b/init/vm_planes.c
@@ -25,6 +25,7 @@ struct vm_plane_parse_state {
 	unsigned int vcpu_count;
 	unsigned int kernel_format;
 	char kernel[VM_PLANE_KERNEL_NAME_MAX];
+	char cmdline[VM_PLANE_CMDLINE_MAX];
 };
 
 #define VM_PLANES_UNSET_VALUE	((phys_addr_t)~0)
@@ -141,7 +142,7 @@ static int __init parse_plane_cfg_line(const char *line, size_t len,
 				       struct vm_plane_config *plane_cfg,
 				       struct vm_plane_parse_state *state)
 {
-	char tmp[192];
+	char tmp[VM_PLANE_CMDLINE_MAX + 64];
 	char *p, *key, *val;
 	unsigned int plane_id;
 	u64 parsed_u64;
@@ -229,6 +230,25 @@ static int __init parse_plane_cfg_line(const char *line, size_t len,
 		return 0;
 	}
 
+	if (!strcmp(key, "CMDLINE")) {
+		size_t val_len = strlen(val);
+
+		if (val_len >= 2 && val[0] == '"') {
+			if (val[val_len - 1] != '"')
+				return -EINVAL;
+			val[val_len - 1] = '\0';
+			val++;
+		}
+
+		if (strscpy(plane_cfg[plane_id].cmdline, val,
+			    sizeof(plane_cfg[plane_id].cmdline)) < 0)
+			return -E2BIG;
+
+		strscpy(state[plane_id].cmdline, val,
+			sizeof(state[plane_id].cmdline));
+		return 0;
+	}
+
 	if (kstrtou64(val, 0, &parsed_u64))
 		return -EINVAL;
 
@@ -292,6 +312,7 @@ static int __init parse_vm_planes_kconfig(const char *buf, size_t len,
 		state[i].memory_size = VM_PLANES_UNSET_VALUE;
 		state[i].vcpu_count = 0;
 		state[i].kernel[0] = '\0';
+		state[i].cmdline[0] = '\0';
 	}
 
 	while (p < end) {
-- 
2.55.0

