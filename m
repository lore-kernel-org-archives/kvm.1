Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA96742FCDE;
	Wed,  5 Aug 2026 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927829; cv=none; b=k8UcmdOZ3pMt2HK1ua8Shioy5+4y53WynK6lBtKuFrv8bgpIClMnGKFiBrzGuniMMKMdK7wv+AntyWx83ZpZXfeOmR3P7X6Jlhti5BGc/AMBbjn53pZ/nfE3XWRT8mqS7Mo2QboV6kvgnsMLff7lAxOxJ3c+mWvtQKvKVeeeq0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927829; c=relaxed/simple;
	bh=7JSY13KGScBy6F7PuLTG7DsSzKo6AwkqgIvHgiWmu9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEC368IN+kTw2fWU9G3ul/vsGPRjVQg2JfBCnJovR3NFR8Pwck2E2mvQyhcKZs/snzZEfjrMY4aEvrIir6EdXn06Khiryic0SDMBiFDq4uo/s3ovMzndxdJP6HNImlhVPVwXKWC748g3Yi6432mz31wAD5GDG8H8sePyJBOFIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=quv4WmNt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="quv4WmNt"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id C71B220B716E;
	Wed,  5 Aug 2026 04:03:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C71B220B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927806;
	bh=iR/umNSTyojyj4H/NIwYEl6RjfILL3Ggtuvntnwdf+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=quv4WmNtrW+l6vStDs0L6FWJJi/BFQAYRlCvjT425YS3WtVgaYehVLFLrZv+yObJI
	 XzueknOQMmQoWREqUbdFxbiZ+wgRkdo1zig6SAvjLkoL43bNaMDEButGF49Pnv5qXf
	 J8xis3OotsxnyspfvbzOitQWF0PVWhErHWvMjpIc=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 06/42] Use vcpu count from the plane configuration
Date: Wed,  5 Aug 2026 04:02:48 -0700
Message-ID: <20260805110324.25067-7-snambakam@linux.microsoft.com>
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
 include/linux/vm_planes.h |  1 +
 init/vm_planes.c          | 37 ++++++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/linux/vm_planes.h b/include/linux/vm_planes.h
index 4a91dc79b7ba..506de566cbd5 100644
--- a/include/linux/vm_planes.h
+++ b/include/linux/vm_planes.h
@@ -12,6 +12,7 @@
 struct vm_plane_config {
 	phys_addr_t load_offset;
 	phys_addr_t memory_size;
+	unsigned int vcpu_count;
 	char kernel[VM_PLANE_KERNEL_NAME_MAX];
 };
 
diff --git a/init/vm_planes.c b/init/vm_planes.c
index 30f17da92332..8eafb1c5f8cf 100644
--- a/init/vm_planes.c
+++ b/init/vm_planes.c
@@ -18,9 +18,10 @@ static bool __initdata enable_vm_planes_requested;
 #define VM_PLANES_DEFAULT_COUNT		1
 
 struct vm_plane_parse_state {
-	phys_addr_t have_load_offset;
-	phys_addr_t have_memory_size;
-	char have_kernel[VM_PLANE_KERNEL_NAME_MAX];
+	phys_addr_t load_offset;
+	phys_addr_t memory_size;
+	unsigned int vcpu_count;
+	char kernel[VM_PLANE_KERNEL_NAME_MAX];
 };
 
 #define VM_PLANES_UNSET_VALUE	((phys_addr_t)~0)
@@ -203,8 +204,8 @@ static int __init parse_plane_cfg_line(const char *line, size_t len,
 			    sizeof(plane_cfg[plane_id].kernel)) < 0)
 			return -EINVAL;
 
-		strscpy(state[plane_id].have_kernel, val,
-			sizeof(state[plane_id].have_kernel));
+		strscpy(state[plane_id].kernel, val,
+			sizeof(state[plane_id].kernel));
 		return 0;
 	}
 
@@ -218,13 +219,21 @@ static int __init parse_plane_cfg_line(const char *line, size_t len,
 
 	if (!strcmp(key, "LOAD_OFFSET")) {
 		plane_cfg[plane_id].load_offset = parsed;
-		state[plane_id].have_load_offset = parsed;
+		state[plane_id].load_offset = parsed;
 		return 0;
 	}
 
 	if (!strcmp(key, "MEMORY_SIZE")) {
 		plane_cfg[plane_id].memory_size = parsed;
-		state[plane_id].have_memory_size = parsed;
+		state[plane_id].memory_size = parsed;
+		return 0;
+	}
+
+	if (!strcmp(key, "VCPU_COUNT")) {
+		if (parsed_u64 == 0 || parsed_u64 > UINT_MAX)
+			return -EINVAL;
+		plane_cfg[plane_id].vcpu_count = (unsigned int)parsed_u64;
+		state[plane_id].vcpu_count = (unsigned int)parsed_u64;
 		return 0;
 	}
 
@@ -259,9 +268,10 @@ static int __init parse_vm_planes_kconfig(const char *buf, size_t len,
 
 	memset(*plane_cfg, 0, *plane_count * sizeof(**plane_cfg));
 	for (i = 0; i < *plane_count; i++) {
-		state[i].have_load_offset = VM_PLANES_UNSET_VALUE;
-		state[i].have_memory_size = VM_PLANES_UNSET_VALUE;
-		state[i].have_kernel[0] = '\0';
+		state[i].load_offset = VM_PLANES_UNSET_VALUE;
+		state[i].memory_size = VM_PLANES_UNSET_VALUE;
+		state[i].vcpu_count = 0;
+		state[i].kernel[0] = '\0';
 	}
 
 	while (p < end) {
@@ -279,9 +289,10 @@ static int __init parse_vm_planes_kconfig(const char *buf, size_t len,
 	}
 
 	for (i = 0; i < *plane_count; i++) {
-		if (state[i].have_load_offset == VM_PLANES_UNSET_VALUE ||
-		    state[i].have_memory_size == VM_PLANES_UNSET_VALUE ||
-		    !state[i].have_kernel[0])
+		if (state[i].load_offset == VM_PLANES_UNSET_VALUE ||
+		    state[i].memory_size == VM_PLANES_UNSET_VALUE ||
+		    !state[i].vcpu_count ||
+		    !state[i].kernel[0])
 			return -EINVAL;
 	}
 
-- 
2.55.0

