Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E52E36607D
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782172508; cv=none; b=nR80PMALFybCLb1M/HwGahTHTIkVVhrRLeFxQj8ilInRcDoioQmstd2lDwJ+nFa/Z/pHL9jQvz9A4+11O6qCDX9NFzy/yySvJs/NGAF3Zu80B/c1LVt+ORM3fPvHJp7BL3j+IiSe7G54GXugmm9G2qo0zj0oQo+QaVDra5PHZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782172508; c=relaxed/simple;
	bh=4+XW0wS4GPLWKZihV9FKtxXfAVhAGSYLkXn+Fk5FBrg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HrhIu0iEv4e87IUQjFvvkTeAf6sfdxs0y6jiC5OzYnBT9i15jqG04CAV/WaLfkxjydOqnzCBhM+RN4l/LnrpcKU0ggTuQek3Dk8HbA9Tc5ApOc1BYqGyMLwZxPkDx9UUgPZfHlRth6iNHOrMrtBZQa7eg/kGjozA0QQnlyVBPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TOl76CCO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOl76CCO"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2a4babe45so31946365ad.2
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 16:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782172506; x=1782777306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcNEYq3Q4R8B4zmWpMGTdvRzGqoFvElrUkkb4tMYFek=;
        b=TOl76CCOwPbd0c0QJj6X1FRW+eUK1NiHUzMcaCgXBlBpfQI/0rEUEfyz6Sn4oDbJqu
         UNewchNtrAZH0ZNv6ims96hy2kV+JRMl4Bw6zYT3m1nkbfk87bjCyr2/Ctm9eKhtRBJB
         FI2X1AQFQxJae0lVNpSvdfKS5lGxZ9vSuuDY30RC+q5kdNgrgyy4atG0w+EolPgIewSR
         ezBIfXfgjiCUxW29wYK9lc9K+WDqDsTABkLjSdqtPvrKTDLRh3t5fpQsckb1C3StN0L5
         NtX3+1iTJ/OJS4Dcn8hNsqPwujgi1ML/Hpx9dRtg2skW4iieJbgwC/A23ttcNsnY1Nbi
         BkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782172506; x=1782777306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcNEYq3Q4R8B4zmWpMGTdvRzGqoFvElrUkkb4tMYFek=;
        b=FdRoct9m6T0ubC5pdxw59gUxqB9RlnyzSV0OZrgpncKAFiKuyiibc8PG25NfhDZKnp
         pCJLTH3bxXazocXR2tP+7dvvOoGkcxV09WY60UMjTB5Qp8yl0k4StwP0X0wxQwxSB/El
         sYbdLh9ox9GRQ5OYNMmdy/GIjC6U8+rJqqiwTxI9fL3W5oaPNr7fL6YG33rbuECHRacJ
         0WsaOr/zWm4xJlgnUNusCJ158QR5OpsgczeB3Wr3XtpX/NtJsbGlI1eKMVtPNsJQjQbc
         CtfkLqrXfy1THcHG5wI8s/ZhkY36tj4OIy7C46GwzCttT2ipzcDMysK1F7dMafR1XhXe
         T8cQ==
X-Forwarded-Encrypted: i=1; AHgh+RoruhoTUQGLDsHnvjjPwOU7JJgKHplWa6nli3Hns0GL96T1zewLG3V0ciQ6DeJv7XD1hvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Y52pMtpYJzWDHmLSPjdhEh7rSgHI3lmHRH3xrBKbODZ56m7c
	KiYWSkkwAldmzt/j22MOY/yuFjCtm2gCXuOT/riDpQP1xMfMByt9Gt0ufnyiYaKaoBrZVjTW6On
	EfjCi+g==
X-Received: from plpw17.prod.google.com ([2002:a17:902:9a91:b0:2c6:d38e:54df])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eccc:b0:2c7:b709:ed2
 with SMTP id d9443c01a7336-2c7b7091176mr32694785ad.21.1782172506050; Mon, 22
 Jun 2026 16:55:06 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:55:05 -0700
In-Reply-To: <f8d021453f5bb6565fc9c9c2e23e63d8c620e2f4.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618185515.2021642-1-seanjc@google.com> <f8d021453f5bb6565fc9c9c2e23e63d8c620e2f4.camel@intel.com>
Message-ID: <ajnLWcMETdVnKVRc@google.com>
Subject: Re: [PATCH] KVM: x86: Clamp the EOI vector if its OOB instead of
 bugging the kernel
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 19, 2026, Kai Huang wrote:
> On Thu, 2026-06-18 at 11:55 -0700, Sean Christopherson wrote:
> > If KVM handles an I/O APIC EOI exit request with a bad vector, clamp the
> > vector to 255 and hope for the best instead of bugging the host.  In all
> > likelihood, a missed EOI is survivable for the guest, and it's most
> > definitely not remotely fatal to the host, i.e. potentially panicking the
> > host is completely unjustified.  Arbitrarily use 255 for the dummy vector,
> > the goal is purely to ensure the vector is covered by the bitmap.
> 
> 255 is a valid vector.  How about use a CPU reserved one instead (e.g., vector
> 0) and hope for the best?

I was thinking it would be better to err on the side of spuriously exiting to
userspace, versus suppressing an exit?  And I wanted to keep the vector legal,
in case something else in KVM cares about legal vectors?  Hmm, but using 255 is
bad because it likely never be cleared, and thus will block other EOI exits due
to 255 being the highest priority vector.

Ah, and the field is never explicitly initialized beyond the structutre being,
so it's starting state is '0' as well.  My only hesitation with zero is that in
the unlikely case bit 0 is set in ioapic_handled_vectors, userspace will be extra
confused.  But that's easy enough to deal with, just skip the check.

This?

		if (kvm_check_request(KVM_REQ_IOAPIC_EOI_EXIT, vcpu)) {
			if (WARN_ON_ONCE(vcpu->arch.pending_ioapic_eoi < 0 ||
					 vcpu->arch.pending_ioapic_eoi > 255))
				vcpu->arch.pending_ioapic_eoi = 0;
			else if (test_bit(vcpu->arch.pending_ioapic_eoi,
					  vcpu->arch.ioapic_handled_vectors)) {
				vcpu->run->exit_reason = KVM_EXIT_IOAPIC_EOI;
				vcpu->run->eoi.vector =
						vcpu->arch.pending_ioapic_eoi;
				r = 0;
				goto out;
			}
		}

