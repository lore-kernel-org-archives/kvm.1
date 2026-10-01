Received: from mail-oi2-f41.google.com (mail-oi2-f41.google.com [74.125.231.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755923CF21F
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890144; cv=pass; b=Az4ikfHF52MQwYx2VpptcZS+gDf7CVg5IVzemrDwD5vnoRqyKw6tnYxwUb/5Z8bZbUyawiumpW/BJguiJoaGXqe7AsUCaXrpFL9bHo0KO2xqoyfKmUuJyB2tRQYA+5O9VxICRkm0sqJoO02YKunuK4AdXTxy6vlOMiqizqerPK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890144; c=relaxed/simple;
	bh=oTN0XACxPdP2godMJRwnJKugf5Nebxe6J04znKJsbBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSH3W+LZHWIA9AN4xmevEVTisq1MbcRQovnxiCKKfTSJYF0it/XHBllihkT0ldh+K/k/yIy6VWXU6Xe6+tBFog62Lc9y5gSxracgTX7H1gTjpjox3uY0U49i+021wMMYU/Kps5vmyrYu7qdCDhzC7kLnx1YBk/gJDeJYP5I9DT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGq10QFE; arc=pass smtp.client-ip=74.125.231.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGq10QFE"
Received: by mail-oi2-f41.google.com with SMTP id 5614622812f47-4f3d8882065so778418b6e.2
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 14:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790890142; cv=none;
        d=google.com; s=arc-20260327;
        b=sKJWjzY38Vr0Ifp3yV0T9HU7BVWkFCdtObBrc9fv5vpoDB5PVS98gJbz8J0gPjZPMV
         EZmgQaU+tsUdbY3qhOxu4vFT/eIAc/Wu5BPDKuIW878EZ5e80IgdVHdWu2nj2+MOTaa0
         7bgUuv2NVC/Q80qa48OWY5rcv1akIRPSBM79JSdCJO8ZPtOZDL+kUiYtJuvOj2Lz8fG0
         S+8nEb2FIN05/qwbJtZ1UCb/Eii0gyEHgQ89pV0FXdoIDQF4fzz8v3HjGV1s//pkGgSt
         8X3n2l3uPd/MQptWCgth6rr4CQCjtpnwdabnW+lQquZFhR4xXTZv2f3yCOkFPJxI+Lln
         hjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WQ1yE7SGQ1qvkGbYQM1t2aSAp7h/GwrmhNcmVEqa4TM=;
        fh=5kET3GHmytVhU7+r7yY9htVw2/br+oQ4Yfklxx1vWEI=;
        b=s6ldg2OQFhUKzSFG40c1jYAQKnQxxPYpNHusDNk8uQdikCPFgLHCi66I+Bc8y12BtO
         Ha/2g7sdRqw3ZpuXsqVhdtxLQ92L+rXoblCDGZO2wEuUQwrkUQWtXOrCwDfFYEa7doyN
         7rZ9Y2JTtJ988S7Q1Vz54IVpd6h8tSC+L5SKnwFXiGp1oAbxZvbq93sGM6xukmzt8GDe
         WoDhTP8twHR01zxUyCKhktRO754NSHOFYnDRtW6cgDxlPikSJgmMw5LtOR3E2wp4OzWy
         3mM5WjMlSYyVSjrQar5rujucHf16okNfBgci0fZLyIH3umudf0sXeWEjmiKoDSebUSwT
         LOHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790890142; x=1791494942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WQ1yE7SGQ1qvkGbYQM1t2aSAp7h/GwrmhNcmVEqa4TM=;
        b=uGq10QFEvWh+lGhFin+raVvBTvkM83tp6DIaTrp2mTg35Cdip4h1PU37Wsrycm4BLe
         Ryug7pcJTkucAtWMO4D1+OTpF5yz86DUyZDHiq/2M8v0P9/3j+pfaNSik9PO34XjBEND
         yjopHI8MQPbIIHhKuurSXK+oJEHixX34B2hhRFGbj1whX6EnZKQhucCfkQAGUcpob+k5
         GyYDuSjBwkovKwkoO0WZZADSmpceSDI22ACqgFl6REZ9hATKYfez2UacDLG6+rGP3I6e
         xxXGDYCsEhDlvxbK98+WA5Z0FLKPVv6tetTmEA5KtMRnYOf62MRWucYuWEm3zltLIkFY
         0ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790890142; x=1791494942;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WQ1yE7SGQ1qvkGbYQM1t2aSAp7h/GwrmhNcmVEqa4TM=;
        b=pH6fCu2iP7zPNByTTWyMmu8ksFPV86/UaevfbMFw3TZNG85Ft5EsBlVvy+EW6qPR4b
         gLk8HPndL53kLhK2Y9cIAdM9QBgQpsWE8IEa6vpx2cvFOiAULScClW05QdPx1zassbHQ
         3zJ7WU0SOiV/75SYnrKIcldvBGEtpedgfpdukUaGAIOREcoCdoeGTsT2JHhGX8bRekgY
         EFOfxmL8+UbI9G08SwbN3IhT2IYp0JKoGbwgl20/u+pJy6Jk6jgnRJNHmAeZwCJreU9N
         TpHccR2reEi/iTq1kmTiv3MQGYxCgdZ96zyfmFP2HVC5U5/s9JhV/fryYSIiEm5xUzPi
         HmQA==
X-Forwarded-Encrypted: i=1; AKwUvByu0M7nRNOuo5sSx3CpU3vmfzlSVZTNOwtOHciZ75e3oDm/pbPZS/RZISVPXzj9CIt3z4k=@vger.kernel.org
X-Gm-Message-State: AFuF++nP/ES5IGE2m4Rl3iY5phRKRkiyjEqj0K7PSm4AXV2r+sz7YpSH
	giQs5Q10n8HVLlj52IBlKb6uWN4ntIi1yfX7LDXAtIbyCJ9USEBI2xFX7oeZdaMdK3o+0qShI46
	B0diARgFESaJKnhe16N4ca+VRjHUD5pI/Aq2ON3pN
X-Gm-Gg: AYBFou2P8Ly921jGQAGPpBM6ObQCNxuo9YZh0whnC+wVvi4zyUIwwBhPpUWz/ltDoIp
	RPLxAAjFACRgecNMTSV1Wl47T4ppY9Iub3/c+gWQ63a+O1Yp/nozy/iF59SmexSVtW9fBBTlUJZ
	ElVV1wbLLbxp/gK0Ialu0a4CybdE7j4/utewa5pJd9G7lr/TPzyr4wp1Ne7MPBWf6sivaBZLH0u
	np7m9B0Rjg61lVInxQSxqDRI2xqrW6AmDscbdm59lpSzMG5U8Lcl5Br2LCv+djr83YJ540p3l84
	CXuopA0Abf1EdVEKb+55HVa9Tje2RGsZYRJvmqFaR9ReUCbCULRTXAhzVu/hA9iuAkrdds5p50r
	OBc+SqJhgKaB1U6EObeq/tg0njovVFFmXOGj6D4NoI+CTH8HABtwM8q2PqXDDw1SZ4g0rND8rwJ
	lGnK2hA5m07VQEcNjU7wqj+A2E+pPHqXQkmQ==
X-Received: by 2002:a05:6808:c161:b0:4c4:a240:9c3a with SMTP id
 5614622812f47-4f526a4f2eamr499736b6e.4.1790890141800; Thu, 01 Oct 2026
 14:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com> <20261001202234.3794060-2-seanjc@google.com>
 <CADrL8HWDy64UH0N4RCtvgL6zP93jnwr91xjkWerEs1MBV9JH_w@mail.gmail.com> <ar7OMwkZ9bc0tbzC@google.com>
In-Reply-To: <ar7OMwkZ9bc0tbzC@google.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 1 Oct 2026 14:28:23 -0700
X-Gm-Features: AclHuK9a_Pc6Thc4O4ojJav2PU4YvfKX_hMsholjFG7-3LGP_q73xLDGlS33olA
Message-ID: <CADrL8HX3GeCKekMoxMuvD7kM3ebHRCqEohiDHDqK-4_XX4rHxg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] KVM: Reject user accesses to guest memory if
 current->mm != kvm->mm
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 2:18=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Oct 01, 2026, James Houghton wrote:
> > I wonder if it makes sense to add similar hardening to kvm_faultin_pfn(=
).
> > What do you think?
>
> I'm not opposed to explicitly hardening kvm_faultin_pfn(), but I don't th=
ink it
> would add much value in practice.  Far more arch code uses __kvm_faultin_=
pfn()
> directly, and that doesn't have a @vcpu or @vm pointer to do the check.  =
We could
> obviously "fix" that, but nuking the memslots (patches 3-5) will prevent =
all but
> the most ridiculous bugs.  Getting anywhere near __kvm_faultin_pfn() with=
 the
> wrong mm would either mean KVM is doing something amazingly stupid during=
 VM
> teardown, or I guess maybe the scheduler or preempt notifiers went off th=
e rails?

Yeah, fair enough. It would be of pretty limited benefit. Thanks.
