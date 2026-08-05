Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7104448BA2;
	Wed,  5 Aug 2026 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927845; cv=none; b=NalUMgLeC1hls1b/FTXv/z6r6cVLBetIGKMCOg27NIuolVJWJO8yV41losYD9rPn2HGJ1VtB/uXUnJiVcEvEARuSMgAugABOMty1pfhcvMQtsq8dFtMHG8l0lDF7rgQjzd9a4T4OD124Kptqq3RdWetSRZHPaVvCnB0CfOxeW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927845; c=relaxed/simple;
	bh=gBFUIbOHk+eDSzs7cfdaQX/rG5t5JvZrEJ4GdSpcVpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggJgrRmMKG4ZUzysMGR3WsJv7KcNQs6ysJ5A10NovOO43LGS3fO7K7BkoJS/gYyvUlo6AmkfKVl42xKfY4I/TNv9YVd0Fp6Q8TWmq44EnX3CadqXWj9eux4HagDKv8Dn13+GlfnJZU1+4NGAp9z9dxe2i6V+MpMMPbx3lzmc3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ov08LaRf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ov08LaRf"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id AAC2C20B716C;
	Wed,  5 Aug 2026 04:03:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAC2C20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927822;
	bh=xsyECdDxm8Pd/K3eGkOY89BjFdC98SR2phH0+4eP6n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ov08LaRftX1wiqBv+JCdeESgu2eVnNjEtJqK1gCqT2rdhAC+7g6FR/1vKv3lkA+Z1
	 jRDIMucJY6Mrc7L8AQz97wtxZbmWFb6YkdB+lRVoDBHsM7tN2a0Xo3oFLldOUUN4ZS
	 Ftxls2G5AyXoxF2XO7niRQniM5VINujqntD2qPz8=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 23/42] kvm: x86: fix merged plane API/stat build regressions
Date: Wed,  5 Aug 2026 04:03:05 -0700
Message-ID: <20260805110324.25067-24-snambakam@linux.microsoft.com>
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
 include/uapi/linux/kvm.h | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index dfc9c7dab21e..348628c7b17e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1689,29 +1689,6 @@ struct kvm_memory_attributes {
 #define KVM_MEMORY_ATTRIBUTE_NO_WRITE          (1ULL << 4)
 #define KVM_MEMORY_ATTRIBUTE_NO_EXEC           (1ULL << 5)
 
-/*
- * Per-plane memory protection attributes (VM planes / VBS).
- * These control EPT R/W/X permissions enforced by the hypervisor on
- * behalf of a higher-privilege plane (e.g., plane-1 restricting plane-0).
- */
-#define KVM_MEMORY_ATTRIBUTE_NO_WRITE          (1ULL << 4)
-#define KVM_MEMORY_ATTRIBUTE_NO_EXEC           (1ULL << 5)
-
-/*
- * Set memory attributes on a specific plane's address space.
- * Used by a higher-privilege plane to restrict a lower-privilege plane's
- * EPT permissions (e.g., plane-1 making plane-0 kernel text read-only).
- */
-struct kvm_plane_memory_attributes {
-	__u32 plane;        /* target plane index                        */
-	__u32 flags;        /* must be 0                                 */
-	__u64 address;      /* GPA (page-aligned)                        */
-	__u64 size;         /* size in bytes (page-aligned)              */
-	__u64 attributes;   /* KVM_MEMORY_ATTRIBUTE_NO_WRITE / NO_EXEC   */
-};
-
-#define KVM_SET_PLANE_MEMORY_ATTRIBUTES	_IOW(KVMIO, 0xd6, struct kvm_plane_memory_attributes)
-
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
 #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)
 #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)
-- 
2.55.0

