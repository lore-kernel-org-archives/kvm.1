Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F819F137
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 00:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198441; cv=none; b=NidmiPvFYsOokWa8h6CEMhT4sLSftZU52fQN4AByqCe9gR5iUZTRgCZEHiUVSJyYx5GWnEk96md2zxvf9mhzdn7nBLzYFRmeuO26ZLzcr7zq3SopdkgL7oxw/zykwFNuOiA8uE7e7VXOgyyvVf6C+PtSCxhm4aI92ctOcGZ8mWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198441; c=relaxed/simple;
	bh=alQQ26vtWvd5KFj0NrkrESuOW1SHNgTSSy6eUycpSEM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZDrXZSPq2ivZC+5MSmN3WYGzadgsTFnjb5GL+os3yMSvH03e46WeuxwfRg5r0hgz9wwyIZuQXNNuHO4Bwixz6h79NcpPfcwelYb6bVjC7UNUV7/oEkC0801fQ9EaVyP3juTDGUBVTIvQksXoypAB+qJ/5uDj4veNzyNXeT70124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ggncy25V; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggncy25V"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-887c99013edso273252b3a.3
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 17:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792198439; x=1792803239; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q4/0F4cnJR4U7rEfwJymIH2uxAq9mMyOs2TKpXvv5og=;
        b=ggncy25VWISJ21Z3/HU3fjADOcxV0aRVb50FOZtotMAG0DJthFUUqXkbWpIMX2WChv
         d5YLZ3v9NF4DfKAb2baZru+bQRJWGqCpxtXhAKO67gfb0xnu+ienniD/PjeKmrtIQiqN
         8Hqw+FhsNm+EncWb7T8iZ/ZQiYkPrWWI0ehtAOV1tB0s8pghwPWX9jGLGT9JRJjBgIUx
         L92R6EeR06an7+CwNaCEcelj62LWlBXdc+5bkf/ZbOUjcMkmDaW9rbSClTdNCH0NndBf
         G4guGbRSjW+6/Yu7cFQDA5MBeQi9mlN/0fNhQcfW4CF2b8iaITpWUHLjbeTo7aEup5jF
         ZrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792198439; x=1792803239;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4/0F4cnJR4U7rEfwJymIH2uxAq9mMyOs2TKpXvv5og=;
        b=qTpJYNIWtFkeyF4s/nfeGAVTL+IDxGAxibiVDDOAjJMfieu8FVz4ZnBO0qp5NUrtQo
         TfgQetSjQrwPRrgUkbnqPLm4cmtZYysYpoRgP7V2SqKbGV7USYsL2cowPRP1sdKFz5S5
         8bNi2Tc0FORs4L8acH3gA30hSIShVcGyGfZg7Zc4lx8dCjP59HEzYjZxBoz0n+O3ebce
         kADtWySkHMkyFBgJMiCH0cdcmx7Sev9LEA3CYY4EOm5GBdYu1l2En7IqFiP0FObiUU6W
         yceNpYOZi7Xm1x+m0jWNc/jibJeu/mtZgZD8gAl56LBSV5sM1tS3Rp/oqYKMJaWCCuzD
         UEQw==
X-Forwarded-Encrypted: i=1; AKwUvBwSM2uQhapPVr38I4BPZJja28L/A6WRhfqmdPcl3Mlkpskr5RbATv3YbA57MleDnXL+LD4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaaHGRIVnnpPVr8OLLixbN9+FYy4zZvERm7ZraFRsWHWNSfaU6
	wmwNyw3wmWh5pn0kUuhMQzqZKuoQI/EZQnA/F0s60/UFKKeWK26fCwWrgVWmRlT20K30ahAewT9
	cjg1LuA==
X-Received: from pgca7-n1.prod.google.com ([2002:a05:6a02:6387:10b0:cc7:52da:b682])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0a:b0:3e2:200b:dc1b
 with SMTP id adf61e73a8af0-3e225fec787mr773961637.51.1792198439153; Fri, 16
 Oct 2026 17:53:59 -0700 (PDT)
Date: Fri, 16 Oct 2026 17:53:58 -0700
In-Reply-To: <20261016235221.33726-4-amirmohammad.eftekhar@cispa.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016235221.33726-4-amirmohammad.eftekhar@cispa.de>
Message-ID: <atLHJpJUXJKNZ09L@google.com>
Subject: Re: [BUG/RFC] KVM: nVMX: nested_get_vmcs12_pages() kills the VM when
 the APIC-access page is unbacked, unlike its sibling pointers
From: Sean Christopherson <seanjc@google.com>
To: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Oct 17, 2026, Amirmohammad Eftekhar wrote:
> Hi,
> 
> nested_get_vmcs12_pages() (arch/x86/kvm/vmx/nested.c:3448) maps three
> L1-supplied guest-physical pointers into vmcs02 on nested VM-entry. Each is
> VALIDATE-checked for format only (page_address_valid / legal-aligned-gpa),
> never for backing, so a legal-format GPA with no memslot passes every
> consistency check and can only fail at the kvm_vcpu_map() step. When that map
> fails, the three pointers are handled three incompatible ways:
> 
>   apic_access_addr        -> vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR,
>                              suberror EMULATION, return false. The VM dies
>                              (every userspace VMM treats INTERNAL_ERROR as fatal).
>   virtual_apic_page_addr  -> clears CPU_BASED_TPR_SHADOW, or writes INVALID_GPA
>                              to force a clean VM-entry failure -> L1 gets a
>                              well-formed VMfail.
>   posted_intr_desc_addr   -> pi_desc = NULL; clears PIN_BASED_POSTED_INTR and
>                              runs L2 anyway, with no signal to L1.

...

> Question / suggested direction: should the apic_access arm be made to fail the
> nested entry cleanly (as virtual_apic does), rather than kill the VM?

No.  KVM goes out of its way to limp along if the vAPIC or PID pages are bad,
mostly to play nice with tests and pedantic developers.  AFAIK, there's no good
option to allow the VM to limp along.  If someone has a strong use case *and* a
"fix", they are more than welcome to post it.
