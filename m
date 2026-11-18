Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997268;
	b=PWRT/uYu8Tfdj0BGQ9aXbmRquTq7oHfCkCwB9QNTyRsC6IhT8lWvee3dNszuY2dR9FoQ
	 xcrqD9DBzI/1dd7UoPpzp9IBcWRE+pjmvl87eQnYlJZh0OuAB+Dm2S3YlSrSdh5jf4L14
	 6sBQo7eOAMXiA+8Rm4G+q4+mI3664ICp7q3IrAeVXgunPYszFDj9E7mAiEOOscLukrhlp
	 GtMMv2u9QZU72sadsgaJq5yqngkEyHQVxDZq05Qq7b1EtQgIHv3EN6DphcC+MBddh+lv4
	 HL+KiWFjhAuXiAARc4iqDA2JQVdRlo+ZIhuNgYFaMr19kC65jCb/DFEI2IE2NL8+obw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997268;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=r0RqCgFglr6kB4r3TuGkycOFWmb74mbV5L7vdYoijp8=;
	b=EEOYErGLm2MaZYBryr0o1EkXgaTRXLXVssu/PfGVpAnJLqzm+l9/+oS8JnMo6kgB13R4
	 apwurM7xc4SHS3zNvZdfprgJ2NwnnmtYAAbUsv7x18RbKwjDEXN0sT+oTrJ5B0pOQK9Ba
	 +msfIrWbIkqSpZ/oqWl3ApQVzVSIPtI/SsZmGiT8qC+XgurI1qHxxon+MoH50VyAbyLQS
	 xk7R+NdHpyBbTLkpt1NUnfIG4bwjC48zgCxYhZJ30SyRbPzjXI2cshK+Dbzwb0MZAR6lw
	 UUWXTH0k7eQ/RrKBo/6bBcXjyL/DMUDyTWYxlKQmqOw6fI8TTvT85wd6fO8vhGU/aKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="m1o/k522";
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E5606A31C;
	Wed, 18 Nov 2026 10:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 942E5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=m1o/k522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=r0
	RqCgFglr6kB4r3TuGkycOFWmb74mbV5L7vdYoijp8=; b=m1o/k522nqwdXg7ePx
	c34cFrgItTX0OIZdETjwuBX91YPVQA4S/LN7W99UNxnXF1FXmyN1DLVn5suFuX9f
	inL/k3qOre4pzM03jl4/cmfrUc4uQVhPb5DbIjgfTWmDbz0F8FJw/j5G/WRYl8/N
	MK/rPXSrGe5vJHB/0+KrFRGY8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDn1Dbee_1quA9NIg--.33070S2;
	Wed, 18 Nov 2026 18:20:14 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	farosas@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH v2] KVM: PPC: Book3S HV: Clean up on uvmem initialization failure
Date: Wed, 18 Nov 2026 18:20:12 +0800
Message-Id: <20261118102012.2252221-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn1Dbee_1quA9NIg--.33070S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF17tFy5AFWfWFW3uw1xKrg_yoWfZFXE9w
	40qan7uw45Jr4Uu3WkZa9IgF4UJr48JrWF93yYq3srJFZ8Zws0k397trnxZry8W39FyrZx
	uay0yr9xtr1SkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtKsjDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7R4wnmr9e97cbQAA3e

When kvmppc_uvmem_init() fails, kvmppc_book3s_init_hv() returns
directly, bypassing the existing error path. Jump to the existing
error path to clean up before returning the error.

Fixes: 175be7e5800e ("KVM: PPC: Book3S HV: Free allocated memory if module init fails")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
 - Change the Fixes tag.
 - Modify the patch title.
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 22283d46e8fe..620097f292b8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6743,7 +6743,7 @@ static int kvmppc_book3s_init_hv(void)
 	r = kvmppc_uvmem_init();
 	if (r < 0) {
 		pr_err("KVM-HV: kvmppc_uvmem_init failed %d\n", r);
-		return r;
+		goto err;
 	}
 
 #if defined(CONFIG_KVM_XICS)
-- 
2.25.1

