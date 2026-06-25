Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90530276A
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782428973; cv=none; b=dxkuD3BFelCxCXJ02yowyOr6ac7tC+dlyCfXubgDDVCD8NbvL9+9qcntNA2h/WQhjlPn8QZBCsuIQmnwO0yVtxlawyq6bLdCZSGynJ1G9tZD7yP729rIzlRCDuUa2jnN1Z5A0xiFCRn+9B1zm727HrD4F/4YIpioI3TXcm1i+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782428973; c=relaxed/simple;
	bh=aLo5j/Saxu4ChpJ9oH5we86JO4qrWCusP9y5SO8hk4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EWLL6ewpgJBoYEgozXG9y5+N1BfbrapC276zQHTaHOVtkYKZ/k1fbjyqnBiMkaLdY7/Ey7+pgrdhWgZgq2gygP4EWzewJejbp/pOq1TewoAniQuR+d3KEN+rXteGDvtR97+oU5YaH0vPh9WCuaf3Wdi+lggp3EAHGlMZ9Cz6gT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7zRxdME; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7zRxdME"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8422ca754d8so141249b3a.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 16:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782428971; x=1783033771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+4zjqfPBoSsvDtMuL3+4LY6xbszbSt+cGsYmfVXwWs=;
        b=k7zRxdMEMU0fJe2ehVi/A8cXJWbi4K30/SByi9CApAcxl8IcYq2Vlq6zSsGQW5w932
         veJ5OWmVss0Hww64vnUSQIDF68ZS/5YZtoiS5tNSmHNc3cGfucqYeOCdbK+pAocCv62r
         AGP8NPbm42QxJCFX5bzj6rf6jWbHa9LqOQnvq0rT9pM83iC2IJN9EFFoHovpZN56Zn1D
         W2GFPb0fpCEbiRwXM8lsjYUYqSqt/A7/vMdYQNuL34ilBuvcOjzjSGC50s9YxZ5/BMGc
         crVL9bDF26myDm1UYObnec9CbxbAOS3me7C0NS77M869HsWib/eMFzfihbNNZorbqCUV
         6Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782428971; x=1783033771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+4zjqfPBoSsvDtMuL3+4LY6xbszbSt+cGsYmfVXwWs=;
        b=gUfTc3GeYTS+SKDivRkvqA0i+0YC4QsaK9jNaNQtYT6TPn7nblTr831Q+9EF7VjRP0
         7EObXmJc4WcghoVzaXMjZWfoOGHdP/sIEbo6yWoBeZDzu9uRIb4akvfGueKVtM3ibXOY
         zDQoe8KUYIznC/iCYrUJwkWApsCouJTX1fphG4Q3bAbdDY2vYAX96PQnCVaNvj/vWicT
         wGediqn4timxjQEX2ybL5jGBN23/rSsk9ioyUJ7ptSeFvm9rDeXnVxZzc49G8RE9VaR7
         KtO57MM2K3sedb2DqYJfYcfNY00/MEQOJlCoohDIHL+H7dcFqvRfhEaGaP2A60L0o/ZN
         DWfg==
X-Forwarded-Encrypted: i=1; AHgh+RoBO/dTTlSn8myyFtBlzJf5HuOZ8LoozDYPO7D5fcccEL82nALw+2YuURwRjDDgHEmXYB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxozl2sVxqYXwNYGotEjWNOctM+H0RkOn5bdKa6kQCgmRR9UW+8
	UvBu6J/l7gJplgE3qdat8n70p5+xE7+MtlPAR0BRZPty9gqq14ZLy+NcBI6Qzv+zfC5SUYfZA4e
	VEI/h0w==
X-Received: from pfbjf8.prod.google.com ([2002:a05:6a00:6e48:b0:845:b9e9:fcd1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22d4:b0:845:c799:3651
 with SMTP id d2e1a72fcca58-845c79938a3mr333179b3a.16.1782428970385; Thu, 25
 Jun 2026 16:09:30 -0700 (PDT)
Date: Thu, 25 Jun 2026 16:09:29 -0700
In-Reply-To: <c855535b4262ecd41f67734d19e8f48a7f014c2a.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <c855535b4262ecd41f67734d19e8f48a7f014c2a.camel@infradead.org>
Message-ID: <aj21KctIXuf7b_5G@google.com>
Subject: Re: [PATCH] KVM: x86/xen: Add KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 28, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Commit 3617c0ee7decb ("KVM: x86/xen: Only write Xen hypercall page for
> guest writes to MSR") blocked host-initiated writes from triggering the
> Xen hypercall page setup, to fix an SRCU usage violation when the
> hypercall MSR index collides with a real MSR written during vCPU reset.
> 
> However, some VMMs legitimately need to trigger hypercall page setup
> from host context. For example, a VMM may intercept the guest's MSR
> write to track an epoch (for kexec/crash recovery), and then replay the
> write as a host-initiated KVM_SET_MSRS to populate the hypercall page.
> The host_initiated check breaks this use case.
> 
> Add KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE as a new vcpu attribute
> that explicitly invokes kvm_xen_write_hypercall_page() under proper
> locking. This gives userspace a safe interface to trigger hypercall page
> setup without going through the MSR write path, preserving the
> host_initiated defence in depth while restoring the lost functionality.

This is all kinda silly.  Userspace provides KVM a blob, then userspace intercepts
the MSR write that triggers doing something with said blob, only to call back into
KVM to consume the blob that userspace provided in the first place.

Any chance we can deprecate KVM's kvm_xen_write_hypercall_page(), and instead
rely on userspace to fill the page?  This extra bit obviously isn't much code to
carry, but it's yet one more Xen thing to maintain, and we've accumulated a lot
of those over the years...

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 91fd3673c09a..c16b4560c9e7 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -907,6 +907,13 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
>  {
>  	int idx, r = -ENOENT;
>  
> +	/*
> +	 * kvm_xen_write_hypercall_page() manages its own locking.
> +	 * Handle it before taking xen_lock to avoid a deadlock.

Do we actually want the side effects that necessitate taking xen.xen_lock?  From
a uAPI perspective, it's odd to effectively bundle KVM_XEN_ATTR_TYPE_LONG_MODE
into KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE.

The other question is, why does kvm_xen_write_hypercall_page() drop xen_lock
when writing guest memory?  That seems odd and unnecessary.

> +	 */
> +	if (data->type == KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE)
> +		return kvm_xen_write_hypercall_page(vcpu, data->u.gpa) ? -EIO : 0;

-EIO is rather weird, wouldn't -EINVAL be more appropriate?  Ah, and both are
wrong if copying the blob fails.

> +
>  	mutex_lock(&vcpu->kvm->arch.xen.xen_lock);
>  	idx = srcu_read_lock(&vcpu->kvm->srcu);

Speaking of writing memory, kvm_xen_write_hypercall_page() expects the caller
to be in a read-side SRCU critical section (I didn't actually run this with
PROVE_LOCKING=y, but I don't think I'm missing anything?)

So, if this uAPI is unavoidable seems like we want something like the below.
Either that or guard all of kvm_xen_write_hypercall_page() with a lock, and put
the entire thing in a helper so that KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE
can be handled in a case-statement and doesn't need to grab SRCU on its own.

---
 arch/x86/include/uapi/asm/kvm.h |  3 ++
 arch/x86/kvm/x86.c              |  3 +-
 arch/x86/kvm/xen.c              | 64 ++++++++++++++++++++-------------
 3 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 1585ec804066..7732b92a4db0 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -598,6 +598,7 @@ struct kvm_x86_mce {
 #define KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG	(1 << 6)
 #define KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE	(1 << 7)
 #define KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA	(1 << 8)
+#define KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE	(1 << 9)
 
 #define KVM_XEN_MSR_MIN_INDEX			0x40000000u
 #define KVM_XEN_MSR_MAX_INDEX			0x4fffffffu
@@ -706,6 +707,8 @@ struct kvm_xen_vcpu_attr {
 #define KVM_XEN_VCPU_ATTR_TYPE_UPCALL_VECTOR	0x8
 /* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA */
 #define KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO_HVA	0x9
+/* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE */
+#define KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE 0xa
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0626e835e9eb..ced19e84bf6c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2287,7 +2287,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		    KVM_XEN_HVM_CONFIG_EVTCHN_2LEVEL |
 		    KVM_XEN_HVM_CONFIG_EVTCHN_SEND |
 		    KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE |
-		    KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA;
+		    KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA |
+		    KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE;
 		if (sched_info_on())
 			r |= KVM_XEN_HVM_CONFIG_RUNSTATE |
 			     KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index db10f12d10cf..b72845aa67e2 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -904,6 +904,8 @@ int kvm_xen_hvm_get_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 	return r;
 }
 
+static int __kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data);
+
 int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 {
 	int idx, r = -ENOENT;
@@ -1138,7 +1140,9 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 			r = 0;
 		}
 		break;
-
+	case KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE:
+		r = __kvm_xen_write_hypercall_page(vcpu, data->u.gpa);
+		break;
 	default:
 		break;
 	}
@@ -1274,30 +1278,12 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 	return r;
 }
 
-int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
+static int __kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 {
-	struct kvm *kvm = vcpu->kvm;
 	u32 page_num = data & ~PAGE_MASK;
 	u64 page_addr = data & PAGE_MASK;
 	bool lm = is_long_mode(vcpu);
-	int r = 0;
-
-	mutex_lock(&kvm->arch.xen.xen_lock);
-	if (kvm->arch.xen.long_mode != lm) {
-		kvm->arch.xen.long_mode = lm;
-
-		/*
-		 * Re-initialize shared_info to put the wallclock in the
-		 * correct place.
-		 */
-		if (kvm->arch.xen.shinfo_cache.active &&
-		    kvm_xen_shared_info_init(kvm))
-			r = 1;
-	}
-	mutex_unlock(&kvm->arch.xen.xen_lock);
-
-	if (r)
-		return r;
+	struct kvm *kvm = vcpu->kvm;
 
 	/*
 	 * If Xen hypercall intercept is enabled, fill the hypercall
@@ -1310,7 +1296,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		int i;
 
 		if (page_num)
-			return 1;
+			return -EINVAL;
 
 		/* mov imm32, %eax */
 		instructions[0] = 0xb8;
@@ -1329,7 +1315,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 			if (kvm_vcpu_write_guest(vcpu,
 						 page_addr + (i * sizeof(instructions)),
 						 instructions, sizeof(instructions)))
-				return 1;
+				return -EINVAL;
 		}
 	} else {
 		/*
@@ -1344,7 +1330,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		int ret;
 
 		if (page_num >= blob_size)
-			return 1;
+			return -EINVAL;
 
 		blob_addr += page_num * PAGE_SIZE;
 
@@ -1355,11 +1341,39 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		ret = kvm_vcpu_write_guest(vcpu, page_addr, page, PAGE_SIZE);
 		kfree(page);
 		if (ret)
-			return 1;
+			return -EINVAL;
 	}
 	return 0;
 }
 
+
+int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
+{
+	struct kvm *kvm = vcpu->kvm;
+	bool lm = is_long_mode(vcpu);
+	int r = 0;
+
+	mutex_lock(&kvm->arch.xen.xen_lock);
+	if (kvm->arch.xen.long_mode != lm) {
+		kvm->arch.xen.long_mode = lm;
+
+		/*
+		 * Re-initialize shared_info to put the wallclock in the
+		 * correct place.
+		 */
+		if (kvm->arch.xen.shinfo_cache.active &&
+		    kvm_xen_shared_info_init(kvm))
+			r = 1;
+	}
+	mutex_unlock(&kvm->arch.xen.xen_lock);
+
+	if (r)
+		return r;
+
+
+	return __kvm_xen_write_hypercall_page(vcpu, data) ? 1 : 0;
+}
+
 int kvm_xen_hvm_config(struct kvm *kvm, struct kvm_xen_hvm_config *xhc)
 {
 	/* Only some feature flags need to be *enabled* by userspace */

base-commit: 8867ab1259b34261eaa96f1f3a2a092cd03e5a17
--
