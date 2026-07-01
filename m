Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221883783AA
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 04:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878478; cv=none; b=Otb+0zNOy2AGn4AFqBCJ7NHkMJ1tAUdTgXcVG44vChw/OJLHVqiKKQz466vbgfF4x5aTAZjPD8jHlK6i4UCTuSYYfLRez5w4lMxq6gg8CwkcGC9KiCs2VZJG5cE8LKEF0pS+R6Gb8rQCxlysviBKEzBjx417B0Qg4mcrSDEWvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878478; c=relaxed/simple;
	bh=HR6LFB3M6+yB82VbVD7Uder2kK5niVbQaSw8XBBfRgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGhmbHaQt280xydbq/9NUZq042KLBjZKwN3cRgFSujxvLez63OqUU8HfixPMLufxv9WQPPTPn5BL6MIshKGsg9C8e5Ah5+JYlwP13MY9DTO6h3z2gfrheIRV/4DrOsmsF+dJjXDxdjpMsLv3MfchpIIAjLqAyMWmZYGkGtCMxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GNTKvFrd; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GNTKvFrd"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30c944aacbaso378701eec.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782878472; x=1783483272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWN7NBari0i1/8aoHDWNlUmTk2Z27L997IJ1yNwTiBc=;
        b=GNTKvFrdGE/x33ErA1FdPSl8gWdg4t5RELmzsvOf2fccUnTSa38gu5H1AkpWKLfjvl
         LAp5/P+E/vTYPpy4VQDq5KNoDBYqp5rcp+axaixXZIfZeiC+6zEWokj2RrUqNruzGxcD
         BEod3Lu9RiVBl0LxOLzQjw1H6JDyBc4gPvN1oacNsT4teHclf+XnvmKvE2q+Fa6vhK10
         qG7dweViVWxOFx+zKZ2eZznPZU8qd4PXXT7hK5bsiCGL9iuKjLrs1z9UrbOyQZPyJnxa
         GvAptB0jKxu061MlMkClYm/y0KrdkTplyZ5c941tNayBuqP69dekJGlT6WlRqQFt9pWP
         vuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782878472; x=1783483272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HWN7NBari0i1/8aoHDWNlUmTk2Z27L997IJ1yNwTiBc=;
        b=Ssm0zDH9QKaP5cZJTQQAHQ41mzYzRYr1vq5x/UeBw6oN31IPYQEW8Eglak+HZj1/EG
         QjpmO4GRISUNGehFKZ9JJXiN+9k4/TY5Tlj2nvoyFzDqywyLK9yx1zdLUMWKh3icJXlV
         N0MphwQXMp+717Lb4YuTldOmfWijDTo0sOoLj5crhJ8/OVWHGty6TBVfu4+fyJsZOO86
         ORfWRhoHWxD6gyRMWBjC5lY2LE5ui1CKzY66JvG9YcYvkck+mGlAh2BVCmQ+z8z7AUbB
         4mg9CAuhCSdvQUidni2gZcVdUmpJJEHlrRJEhQDapLNI1LCtgqoIDIckF0D1PauLI/8l
         GlYw==
X-Forwarded-Encrypted: i=1; AHgh+RojzQMV60uCXVgRlQkkQocezk/sGsMpghXN58eKTHw5NOQaOqycdafi+lN+bmyMXUpVYiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdNzAnf66yi+oK6y44KK5hICwG3OrxzejIgixnPkTFBntGAw42
	n7Qdf1Bzy+3Nuu4VRA6G/1I9vi67JefvgXIayEEsPjrZxUIPZvC6j59wtWt1C4dB6Ts=
X-Gm-Gg: AfdE7cl9jH4VuiNvVXhPDkPTxt1VNFHP5yZirwKFOtOd5kuNUbT4RZmJW4giXwVpTtY
	Sn+JzMGZd6QgFGLGWZU/ky99glVPDm2NBeQaWW5z+PYpSD+m0usq5GdrRAFeB3yEwa+5Gmp7pCi
	JCLL63eE3EaAd6rfefrOq3tM0pS9x1uopNIJ4drag5ecwS4Flw8ndx5au6uBnOg670p22wXA8jy
	zZ3WmfvDHYcePnJ+GzhF1r92TkrcCqdHQdH8fVhreXzdW4idcCezAnfo37qgLIpk7L/erg87s/s
	nNh18ppkwYry9yQ0GAV2gWNTsBHnp+NIn8cF71np3nZR2Ic315aLBft4XqRkjVWK30Za/FNLlkc
	pQzivA38OZBVyjJKY2d5htEeJQg4XT4MjInSVI8ycu09dXRw/uGC11VWTfjY8OHN2fiXlJcWPPg
	rzIM3WMDkodIWOKZ4g1d0PsnTaYefJXYRM0FYUU4mLzcwyXyT7w15FPCgDaIHOBtn5qiMm8jlWT
	XE=
X-Received: by 2002:a05:7301:2a04:b0:30c:52c5:6e3f with SMTP id 5a478bee46e88-30eff0b4e80mr8435eec.18.1782878471619;
        Tue, 30 Jun 2026 21:01:11 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee32519aesm14024287eec.27.2026.06.30.21.01.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 21:01:11 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [RFC PATCH 2/3] KVM: Move irqfd arch data into route snapshots
Date: Wed,  1 Jul 2026 12:00:15 +0800
Message-ID: <20260701040017.42707-3-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701040017.42707-1-zhangzhanpeng.jasper@bytedance.com>
References: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
 <20260701040017.42707-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irqfd wakeup takes a seqcount-protected copy of irqfd->irq_entry before
injecting an interrupt.  Architectures that need to classify an injection
by its irqfd producer need any derived arch state to be part of that same
snapshot.

The irqfd object had per-irqfd arch side state, but that state describes
the current producer, not the specific route snapshot used for an
in-flight injection.  Keeping the metadata there can race with route
updates and teardown: the inatomic injection path may observe a new route
with old arch metadata, or old arch metadata after the route has already
been invalidated.

Add optional arch-owned irqfd metadata to struct
kvm_kernel_irq_routing_entry and initialize it whenever KVM refreshes or
clears an irqfd route.  Remove the old per-irqfd arch side-state fields
so the route snapshot is the only place carrying this producer
provenance.  Userspace MSI injection uses a zero-initialized temporary
route, so it is never reported as irqfd-originated.

This provides the sequencing needed by RISC-V AIA to distinguish MRIF
notice MSI delivery from normal MSI injection without consulting mutable
irqfd state outside irq_entry_sc.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 include/linux/kvm_host.h  | 7 +++++++
 include/linux/kvm_irqfd.h | 4 ----
 virt/kvm/eventfd.c        | 5 +++++
 virt/kvm/irqchip.c        | 4 +++-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5bd76cf394fa..254f8fd132cc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -685,6 +685,13 @@ struct kvm_kernel_irq_routing_entry {
 		struct kvm_hv_sint hv_sint;
 		struct kvm_xen_evtchn xen_evtchn;
 	};
+	/*
+	 * Optional arch-owned irqfd metadata.  It is updated under
+	 * irq_entry_sc together with the route so irqfd_wakeup() observes a
+	 * single consistent snapshot.
+	 */
+	struct kvm_vcpu *irqfd_arch_vcpu;
+	void *irqfd_arch_data;
 	struct hlist_node link;
 };
 
diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index ef8c134ded8a..44fd2a20b09e 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -58,10 +58,6 @@ struct kvm_kernel_irqfd {
 	struct work_struct shutdown;
 	struct irq_bypass_consumer consumer;
 	struct irq_bypass_producer *producer;
-
-	struct kvm_vcpu *irq_bypass_vcpu;
-	struct list_head vcpu_list;
-	void *irq_bypass_data;
 };
 
 #endif /* __LINUX_KVM_IRQFD_H */
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index a7794ffdb976..399ef2bdce5d 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -273,6 +273,9 @@ static void irqfd_update(struct kvm *kvm, struct kvm_kernel_irqfd *irqfd)
 	else
 		irqfd->irq_entry.type = 0;
 
+	irqfd->irq_entry.irqfd_arch_vcpu = NULL;
+	irqfd->irq_entry.irqfd_arch_data = NULL;
+
 	write_seqcount_end(&irqfd->irq_entry_sc);
 }
 
@@ -594,6 +597,8 @@ kvm_irqfd_deassign(struct kvm *kvm, struct kvm_irqfd *args)
 			 */
 			write_seqcount_begin(&irqfd->irq_entry_sc);
 			irqfd->irq_entry.type = 0;
+			irqfd->irq_entry.irqfd_arch_vcpu = NULL;
+			irqfd->irq_entry.irqfd_arch_data = NULL;
 			write_seqcount_end(&irqfd->irq_entry_sc);
 			irqfd_deactivate(irqfd);
 		}
diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 6ccabfd32287..b163f7ed3c1e 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -47,7 +47,7 @@ int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin)
 
 int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi)
 {
-	struct kvm_kernel_irq_routing_entry route;
+	struct kvm_kernel_irq_routing_entry route = {};
 
 	if (!kvm_arch_irqchip_in_kernel(kvm) || (msi->flags & ~KVM_MSI_VALID_DEVID))
 		return -EINVAL;
@@ -145,6 +145,8 @@ static int setup_routing_entry(struct kvm *kvm,
 
 	e->gsi = gsi;
 	e->type = ue->type;
+	e->irqfd_arch_vcpu = NULL;
+	e->irqfd_arch_data = NULL;
 	r = kvm_set_routing_entry(kvm, e, ue);
 	if (r)
 		return r;
-- 
2.50.1 (Apple Git-155)

