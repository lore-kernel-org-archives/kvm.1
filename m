Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640768;
	b=QPZUeNtZ2CYSy5vOgHYTRWwITLrdttYOnSN7mNxbbwcXs/7rpfLQTkkxZHOv+H0H2ZV+
	 AkXqZuKElXPv0b4NBuzqp0AjnS0473Q0Zj4JmulQfaaHsg7OZrISmQ9ayiLbgh5jUMg/I
	 IQlZ5T8TKoCgZx6gFCBzqKWtYdoFdfbTF1171hPxe5Rwafe24wmAO3Qbd10rvo4yuvAWA
	 Gqt0i6RHeuCU4o1AhTTggpf0xr4i/BLZfIMxVYlL7/cY7aMAEzhwd/P2QrBioIQ1WwxPi
	 Aaly+VaslE82EXEv2euCO8LBsh9yfq0/TzmEJ9eSg+uWcL1/ZUGLylazoGLL4bS9AVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=IkAPkFLbTRtEJ98IuWKTdP6Q3cksIi32J1uYLTtOYaQ=;
	b=Ox3DvKpvOxq/N/dzKpE8aegGi6+QGhjeAr0w/dTFKVQ4mNqw9/1J8Q7DuUT8G5Ab74z6
	 VScD7vsCGi9HUFEHXUZQsSrJASmEtuliNM9TWWXlbbqlPVzC1/RdGUYYmxl+Pmt9wWYQ+
	 uZqP8T9ISvEDTwzCba2S7i3ZSS5rmqFC1di+D1wrl7z7G8azYoH+I26g0b9NAKqYqNjmu
	 jVmck2uSyIadrAQTocFpToKyev2+KSt/fmjgPfn1uBzo+w3ZWtlb/YCo9YL8NR8JtSH5b
	 XuKhBLVDtNxcFVFV0PiFSetk7UYGzuCV/X9b1fr2bFywveh3a2e1RILZNXRY8evDLJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U9u6NCxj;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08D606A595
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B08D606A595
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U9u6NCxj
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ad704d4760so2963629a91.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 09:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793640767; x=1794245567; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IkAPkFLbTRtEJ98IuWKTdP6Q3cksIi32J1uYLTtOYaQ=;
        b=U9u6NCxjVhkQwuGcWx66GAOCDWPiOPNc0aRhBiHc6EdbEc0Wd0uvKTupJIGhp41tRt
         jdvKM8tqp2sTK7mylRgtAYxWR4iGLC9RS9/zFsUU7L6b3ZPr4Wl+7DG3P/KziQYvM+Yj
         x2NWnUpMMIW44ep+gzdRlBZUjE4DJNiACdZxMM+jqKdTLzYC/VEWW+6Q+3KWc/+mF6q9
         A0xr04gIiSd2s4IPtnLolaEb9YGHxe6Cziu67tyl1qFyItm3n4JXU1OG2mjAv+VPgst/
         X6Ki18eBlFIP41C6JFzBogJ1VxsK+RmPrySxVDe0gXmlO7u1oJufLiYzogOoVBzFk2XM
         F3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640767; x=1794245567;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IkAPkFLbTRtEJ98IuWKTdP6Q3cksIi32J1uYLTtOYaQ=;
        b=L/+8AhlmyyP6F7cwZWnR/6MKMOhjBXHUOokSnd9sC9tLuphADMCQF3yizTJ/hMEl/g
         xrSrrhLcgXg4qy29//WLuGuMcol8Se9DgLKbCADxsbh++ARkwtKEErpgsQBPX39R6+Hf
         gtLBe68kOPYeZ21DYjHn8wd6I2ZTKMeI3Ywn/M/5qOiqDwFeqh+7B/FMBfEcj0D40nWe
         84mx3uyT2n3BOiBXgaBTyqxX7QssZ0fiCYdSq1/Pdb9iwYPSBwlROIrefl0Pzq50PDTD
         SgLgDrnwPRHhPFx7Hrr5KmvXo8SGNAoq1/GOJeafe6CzpdCWPoVhmlRyuZYOCbbxKzBw
         fCPg==
X-Forwarded-Encrypted: i=1; AKwUvByzSfTYGirUg1+SSIf/7xXR3VtbdEvU4VfAr2kdREtRDQDZuWQHs9/4utiq7YXLlWWMWlk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HmMIZOR9YlxVOLt8wWK//MAw9ux5MY4ivxBLtGRhUC1eikOPp
	4AcnGAzqa1+Vh28k1Pja9asR2kPcU1+56gEgCcakM+UV2h9a1j04mh0duzSxwqVEWdDl1wFYFfg
	Uu8Q4YQ==
X-Received: from pjbir4.prod.google.com ([2002:a17:90b:4684:b0:3a8:74c5:5a5c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a8a:b0:39e:6c69:7777
 with SMTP id 98e67ed59e1d1-3ae8976c86fmr8030769a91.32.1793640766778; Mon, 02
 Nov 2026 09:32:46 -0800 (PST)
Date: Mon, 2 Nov 2026 09:32:46 -0800
In-Reply-To: <20261030103643.573356-4-doebel@amazon.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030103643.573356-1-doebel@amazon.de> <20261030103643.573356-4-doebel@amazon.de>
Message-ID: <aujJPohZEMZMdWFW@google.com>
Subject: Re: [PATCH 6.18.y 3/3] KVM: VMX: Synthesize nested EPT violation
 GVA_IS_VALID/GVA_TRANSLATED bits
From: Sean Christopherson <seanjc@google.com>
To: Bjoern Doebel <doebel@amazon.de>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 30, 2026, Bjoern Doebel wrote:
> From: Kevin Cheng <chengkev@google.com>
> 
> [ Upstream commit 96b067b59ad9ccede585fcadab27543188353bff ]
> 
> When injecting an EPT Violation into L2 in response to a fault detected
> while emulating an L2 GVA access, synthesize the GVA_IS_VALID and
> GVA_TRANSLATED bits using information provided by the walker, instead of
> pulling the bits from vmcs02.EXIT_QUALIFICATION.  The information in
> vmcs02.EXIT_QUALIFICATION is valid/correct if and only if the fault being
> injected into L1 is the direct result of an EPT Violation VM-Exit from L2.
> 
> E.g. if KVM is emulating an I/O instruction and the memory operand's
> translation through L1's EPT fails, using vmcs02.EXIT_QUALIFICATION is
> wrong as the semantics for EXIT_QUALIFICATION would be for an I/O exit,
> not an EPT Violation exit.
> 
> Opportunistically clean up the formatting for creating the mask of bits
> to pull from vmcs02.EXIT_QUALIFICATION.
> 
> Signed-off-by: Kevin Cheng <chengkev@google.com>
> [sean: use plumbed in @access bits, massage changelog]
> Link: https://patch.msgid.link/20260522232701.3671446-5-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [doebel: no advanced EPT vmexit info here, so the mask keeps only the two
> GVA bits; set GVA_TRANSLATED via !(access & PFERR_GUEST_PAGE_MASK)]

...

> @@ -509,6 +509,21 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>  		if (fetch_fault)
>  			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_INSTR;
>  
> +		/*
> +		 * KVM doesn't emulate features that access GPAs directly, e.g.
> +		 * Intel Processor Trace.  Assume the GVA is always valid; when
> +		 * propagating faults from hardware, KVM will discard this info
> +		 * and use the EXIT_QUALIFICATION bits from the VMCS.
> +		 */
> +		walker->fault.exit_qualification |= EPT_VIOLATION_GVA_IS_VALID;
> +
> +		/*
> +		 * Accesses to guest paging structures are not the translation of
> +		 * a guest linear address, i.e. GVA_TRANSLATED must be left clear.
> +		 */
> +		if (!(access & PFERR_GUEST_PAGE_MASK))
> +			walker->fault.exit_qualification |= EPT_VIOLATION_GVA_TRANSLATED;

Yeesh, I was going to say I'd prefer to keep the original:

		/*
		 * Accesses to guest paging structures are either "reads" or
		 * "read+write" accesses, so consider them the latter if write_fault
		 * is true.
		 */
		if (access & PFERR_GUEST_PAGE_MASK)
			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_READ;
		else
			walker->fault.exit_qualification |= EPT_VIOLATION_GVA_TRANSLATED;

but I don't really want to decipher whether or not that's needed and/or correct
without upstream commit a8827c1961462 ("KVM: x86/mmu: introduce ACC_READ_MASK").
So yeah, this seems like the way to go.
