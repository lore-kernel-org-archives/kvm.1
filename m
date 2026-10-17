Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69016288C81
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792246386; cv=none; b=CfjKXWICEhQ5WSFPbfctgVVCHlgAWjxaL+w0J/KFtpGTW+omiDtmaSP8h3fqH3QvTWCx+Li9XTiTjBAe5vNZYY+WLCE1COVHCTc9ByJOgCgz/fsucvEmhmh9OMorRFoyIviWMBGG9Lhxmp2NvzVKu1EUjW2zKTIbFJk6KyQSCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792246386; c=relaxed/simple;
	bh=EX/FzVLznKz1i9Q1JsMD+r5L5kBOVC+1NFVnRF5uMFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QX0U2i1Wd2udTcULV3m6WJYmNCvk1nYWebDmzyEr6AQ8vM3X9SBAyGDP70Sk6+mKTWv9qrl00vQg6mHPFAbMB4ukya2nZhMHf/kebwy5t4VlMFSoK1lu/Vx9gb0I0LrH2aDsCFPudvFP+8yH8ibqLpbKUXhz+l+Hg+voLc4GDe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jWEtqr86; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jWEtqr86"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cec4226c70so6760275ad.1
        for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792246384; x=1792851184; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JCniu1TDC3KaNG6UTHQva21z43WBHuc3cHi+ywDliPM=;
        b=jWEtqr86zVYHhy3D0jq5B2tf3CdZQIYrVnNpoQ31baacycSD+FD1alaH3IgB5JcXzO
         PHMiPCMllLl+P26HMoxfMA/sfOsOOLTnykPOYnqhQBQ65F3hQiM4GFAi96U12fjxTD3w
         E7w7QT+repm6H48G4u+TzpScbYRtbycUEQb0TNQdAvFExRoG45qCxEqnDhyLDngjzbeQ
         kSQ/DYo2MPdYbDEUdUrX03sMJYqXHNA/EP6D9SO2GufEBMzWkXe78RfPXPlIMRgMVjnl
         6FIfzoN2DuvCNRCxYih5Ducqg7qb4Eop4wKmt7Snn6P9iGU8zXOxnxvyWJAEJxJte9bg
         Q7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792246384; x=1792851184;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JCniu1TDC3KaNG6UTHQva21z43WBHuc3cHi+ywDliPM=;
        b=R70dvD77vFnDafHHb4hdcW+mtg0pefNQpNpv8xci1ZC6BM5IoPwbC5PV/5gxDHKmF1
         PtwM2Na9OIXDeO/0OQu0IQw3Cg+89ajwsIGl/s9Ls6fOLKknkJqmaM+7SJVlzZTOk6qR
         0bcHAufsNwwT9vEJqfldy/rt8ky1igYDfDLlbTrYcFk0g6JkzprCndndKrkgWAEacibb
         3phoO2QyA2fMRXZcBCINi2pXPH49joh7CUVzWGKvru1P0bRbde3UI3Ny3/luO6+pZdlR
         LxjLfvRvvxmP7tNWwuQyrVhqzk8ARg1gE09uPvHgZHYRyvEhQ6jq/ASgWAER9TO6FpLR
         0nyw==
X-Forwarded-Encrypted: i=1; AKwUvBwpKXrjGnhYg/AoTfITdIrgM8pL6F9p+lkvt8Z0TgpoFVYpS9mRzUYJuAiUrbzhTCwkTXg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKe7LbaiTl8xd44W5Ct1A/UljS7EcnZRfFqUwUCH4HSsCcabbyA
	bfXjRTOXflQzoxVCwH9eWy5FFeBKGKi9fvReuJvyqDKOIXe1rJjDYXVmNgpLIWPaJ9Xh1nJKe5P
	8zFVfqg==
X-Received: from plbme6.prod.google.com ([2002:a17:902:fc46:b0:2df:6366:11cc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f87:b0:2e9:4f21:91ef
 with SMTP id d9443c01a7336-2e9a69e99f3mr23537045ad.36.1792246383457; Sat, 17
 Oct 2026 07:13:03 -0700 (PDT)
Date: Sat, 17 Oct 2026 07:13:02 -0700
In-Reply-To: <20261017093016.32348-4-amirmohammad.eftekhar@cispa.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261017093016.32348-4-amirmohammad.eftekhar@cispa.de>
Message-ID: <atOCbna3qAQZ1wLn@google.com>
Subject: Re: [PATCH] KVM: x86: Ratelimit guest-triggerable IOAPIC/LAPIC log messages
From: Sean Christopherson <seanjc@google.com>
To: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="us-ascii"

+Josef and Chris

On Sat, Oct 17, 2026, Amirmohammad Eftekhar wrote:
> A guest can drive these kernel log writes at will -- the IOAPIC MMIO
> read/write handlers log every access with an unsupported length, and the
> LAPIC IRQ-delivery path logs each physical-broadcast lowest-priority IPI --
> so a guest can flood the host dmesg/journal.  Use the _ratelimited()
> variants, matching the ratelimited logging already used elsewhere in the
> LAPIC.
> 
> Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
> ---
>  arch/x86/kvm/ioapic.c | 4 ++--
>  arch/x86/kvm/lapic.c  | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> index 0d59b9c75..df15d9401 100644
> --- a/arch/x86/kvm/ioapic.c
> +++ b/arch/x86/kvm/ioapic.c
> @@ -647,7 +647,7 @@ static int ioapic_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
>  		memcpy(val, (char *)&result, len);
>  		break;
>  	default:
> -		printk(KERN_WARNING "ioapic: wrong length %d\n", len);
> +		pr_warn_ratelimited("ioapic: wrong length %d\n", len);
>  	}
>  	return 0;
>  }
> @@ -672,7 +672,7 @@ static int ioapic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
>  		data = *(u8  *) val;
>  		break;
>  	default:
> -		printk(KERN_WARNING "ioapic: Unsupported size %d\n", len);
> +		pr_warn_ratelimited("ioapic: Unsupported size %d\n", len);
>  		return 0;
>  	}
>  
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index ecf611845..7d85a56b6 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1359,7 +1359,7 @@ int __kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
>  
>  	if (irq->dest_mode == APIC_DEST_PHYSICAL &&
>  	    irq->dest_id == 0xff && kvm_lowest_prio_delivery(irq)) {
> -		pr_info("apic: phys broadcast and lowest prio\n");
> +		pr_info_ratelimited("apic: phys broadcast and lowest prio\n");
>  		irq->delivery_mode = APIC_DM_FIXED;
>  	}

This, and more flaws of this nature, were also sent along off-list by Josef and
Chris.  For this specific case, I think what I'll do is combine all of the
APIC ratelimited conversions into a single patch, flip a coin for the Author,
and list the other person as Co-Author.  Any objections to that approach?

Author:     Josef Bacik <josef@toxicpanda.com>
AuthorDate: Wed Oct 7 23:19:48 2026 +0000
Commit:     Chris Mason <mason@kernel.org>
CommitDate: Fri Oct 16 18:07:57 2026 +0000

    KVM: x86: Ratelimit the I/O APIC's access size warnings
    
    ioapic_mmio_read() and ioapic_mmio_write() print a warning for an access
    that is not 1, 2, 4 or 8 bytes long.  The guest chooses the length: a far
    pointer load with a 32-bit operand size, e.g. LDS, reads six bytes, and
    an access that starts in the page below the I/O APIC leaves a fragment of
    any length for it.
    
    A guest that does this in a loop writes to the host's log, and to its
    console, as fast as it can exit, which drowns everything else and keeps
    the CPU busy in the console driver.
    
    Ratelimit the two messages.  They are now prefixed with the module name.
    
    Fixes: 1fd4f2a5ed8f ("KVM: In-kernel I/O APIC model")
    Assisted-by: LLM
    Signed-off-by: Josef Bacik <josef@toxicpanda.com>

diff --git arch/x86/kvm/ioapic.c arch/x86/kvm/ioapic.c
index 0d59b9c758c2..df15d940181c 100644
--- arch/x86/kvm/ioapic.c
+++ arch/x86/kvm/ioapic.c
@@ -647,7 +647,7 @@ static int ioapic_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
                memcpy(val, (char *)&result, len);
                break;
        default:
-               printk(KERN_WARNING "ioapic: wrong length %d\n", len);
+               pr_warn_ratelimited("ioapic: wrong length %d\n", len);
        }
        return 0;
 }
@@ -672,7 +672,7 @@ static int ioapic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
                data = *(u8  *) val;
                break;
        default:
-               printk(KERN_WARNING "ioapic: Unsupported size %d\n", len);
+               pr_warn_ratelimited("ioapic: Unsupported size %d\n", len);
                return 0;
        }

Author:     Josef Bacik <josef@toxicpanda.com>
AuthorDate: Thu Oct 8 13:12:54 2026 +0000
Commit:     Chris Mason <mason@kernel.org>
CommitDate: Fri Oct 16 18:08:44 2026 +0000

    KVM: x86: Ratelimit "Local APIC read with len"
    
    kvm_lapic_reg_read() prints an error for a read within one register whose
    length isn't 1, 2 or 4, i.e. is 3.  The instruction emulator doesn't ask
    for that, but an SEV-ES guest states the length of an MMIO access in its
    GHCB, and kvm_sev_es_mmio() passes up to eight bytes on as they come.
    
    Such a guest can write to the host's log, and to its console, as fast as it
    can exit.  Ratelimit the message, which is now prefixed with the module
    name.
    
    Fixes: 8f423a80d299 ("KVM: SVM: Support MMIO for an SEV-ES guest")
    Assisted-by: LLM
    Signed-off-by: Josef Bacik <josef@toxicpanda.com>

diff --git arch/x86/kvm/lapic.c arch/x86/kvm/lapic.c
index ea3afa5e9fa3..82a2dba1f269 100644
--- arch/x86/kvm/lapic.c
+++ arch/x86/kvm/lapic.c
@@ -1829,8 +1829,8 @@ static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
                memcpy(data, (char *)&result + alignment, len);
                break;
        default:
-               printk(KERN_ERR "Local APIC read with len = %x, "
-                      "should be 1,2, or 4 instead\n", len);
+               pr_err_ratelimited("Local APIC read with len = %x, should be 1,2, or 4 instead\n",
+                                  len);
                break;
        }
        return 0;

