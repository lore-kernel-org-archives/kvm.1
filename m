Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6623F7A9C
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833133; cv=pass; b=lv0/+wuGSdFWzEKfubfVKGgRjTnvjlfRx3NKqG9V7xLeqn7IlBCNdprz5P5spUxlObPrfj2bpdyKlZFgTjrALWJbxpkPDowPUXEKNTxdDAsN2+RVuLZ3Lps7pcVFH6zFwaOMDt/flQ4D+H641yVly3Lu6PlbTLkFWawDY5onmIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833133; c=relaxed/simple;
	bh=4ookdC20QtoZbB1O+DhxvFMGgHfMkUv+Dn9an2aJN+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lq2R/HHyDrURoIvVXo6K+OzQ7O9C9SII7AXV6GrFt9GvcL7oOT9BjUCrk8LDv/NXibQh6AIZ8ysBn5UnRECEQqbq3CJUfytJGZZmR2QUglOpeS1QSNyPbiKLDYFt0uGRobO41A8tI/ukjA3o7bYEbGofplcRyvXOKkea+JZO3Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zeg1knk9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFtJq7sq; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zeg1knk9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFtJq7sq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778833129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6ySHVEB9ALHccJDbDE/wxX846kzOTE5QwgZ7MAa2lM=;
	b=Zeg1knk9ISrGI11ljM2o1zYBlK9UHgvo5WuBoYpT01tWfAzUrheu/Ha7WOLPKBNi5HxCp2
	YQ1Cuq2Q8J84Nj1fBVXn0VzBdI9mfiX2z1+xRq3wdfkD6pcLQ4KwQabK8mGRd6pWZm2yXU
	cH2ihYloBi+D5hj/uG9eyRN0GIMgcHg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-QykqS8FINXCQyKBfpYfrUQ-1; Fri, 15 May 2026 04:18:48 -0400
X-MC-Unique: QykqS8FINXCQyKBfpYfrUQ-1
X-Mimecast-MFC-AGG-ID: QykqS8FINXCQyKBfpYfrUQ_1778833127
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44b186b715aso5524561f8f.0
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 01:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778833127; cv=none;
        d=google.com; s=arc-20240605;
        b=Xmo1AGXODXe4njEtnujgd1UNxijwPZdmITtk10CKzrMH2CNv7JbFilnCmxIfo4MR2y
         8glctf6p5CLli/DQnWbhEm85+wPQxQ2XVG35wvcAQct887fJoDF/O8heYOLVV4zeXi54
         ev+4oKMy8sjIPLUSNu8MpRfHBDS+Kkextk0yvmUrwnnf7Otlexk7/+I6unFupecK8tlg
         jUht6QKroVcWhblvXedfaU661j6rrIM9Ij0HZlhNClRW5OKp4qHWlE7rTC4CPQIqLH8W
         9pYCevw3qWFWFM98g3MuY57N9LMabzctTqhwvTCxLRmWbaHFtfuXHrn9cqMjlAw+iKFR
         CIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l6ySHVEB9ALHccJDbDE/wxX846kzOTE5QwgZ7MAa2lM=;
        fh=bHfb4ZSqVRWfxOG2V6R6xZs2WPoa6jx4qhm8QZbNFwg=;
        b=lsfFdesSXTXNhygQn7hvwWRyxtljn+xSvxqkFAB+8mazZff1Fec68ylZL8eA/aiWZk
         jIYh2J0l17EtcwL2wwiBq+HYJAgoC/nqoSUcoqUIV0hjCiwZzHbAv0YllCftoP5CEjsc
         f0VUSuCS7yD2iWu9XiiPfoI1x8PtwOeshpJcNq82JHE8BwITZAUsSRTfHTj4gVNLLtWi
         +QxvZ/TkhS8ggDKHsWj1OyL7DI9nMFKldTd+ZomdoZDNDVXfXtUaRR2e4DAfE1LlV6LH
         opRBxZdyRyg+iawYTAlqskxc+WRhSZwi9IcmrwIsrnH74pAVNcfaNBq+KelZ+27dl3bd
         vG6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778833127; x=1779437927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6ySHVEB9ALHccJDbDE/wxX846kzOTE5QwgZ7MAa2lM=;
        b=CFtJq7sqHT6aMl4xn/tm8IOLz9eqYd3fQIuHfsh0lmHgDKrwzeEb1PZy4X9t0UQz2Q
         4xVUjN2smKcja1MMm2E8QiB83IP3aDXwjzJicTmzk1n2A3kAgXqbrXZke4At8wot0Yi5
         MIKtE2JfuawDNqivXZUwLa3Xv+BLkLuDWux5W3+Jwg1QQN5TKg5qo1ZqCafFGrEonUGx
         HEKMM7vT9hsaxDZs9VHM9p8Bxq5dJUwoPkDyOBWU22cZPlCc1jq1AK1GiaQ/N0meodEl
         us+G/PX/O7VmYq4nvChTVtfiRXFQYwD7q2qlTRNVqQdZNYfLXgpFhEIr284BYzyMhK49
         WptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778833127; x=1779437927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l6ySHVEB9ALHccJDbDE/wxX846kzOTE5QwgZ7MAa2lM=;
        b=MqXFyFPA3w/+PIbYYAdCZkZWKdkaInzfMSCnnYTMFefwpXrjYDdXErNdiG0I3C/GdQ
         K0BxgN3hWlyiDOrhxDjgylBQsJ3PG0OO/iFsuPGBAmdTsfubucbuUgBtoQtvi4fOlv+W
         O1oMHGGgoiUPEEFtxw6g9XDZdzgS30AyfptidJ6haJ07OG6JjSZfen5dITpe+H+/Ir+o
         /nGhy4Ea8c3kxQRmvX1rdBMCewFG0KjNI7b8aOBSq3jxvPsGqzo2vzVo7eQYNSZ2cQwi
         AzaDdLFgaaXrnEP9eBzd/m66pwbynjXkfWzKj60hd9k4zdAeIkmuHUdkFlQH3Q6LGNyL
         JGkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1H42wPvv88k6+w2OI6+v2xCdRD7dQOF8YLBiMaLU3c+AbKjiAaYX+B02hHTYaPy8r1tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuuTPv+8MhhNGdK9N+IBVMPiF87K6w5Qp3x1ZFWwL6CE5uDtfR
	jYDmxc9fgBk5iWsaPLPkTdmk913pBlJSEOqLjNZ15Lydd1XA5n21O1e0K9CLyADkiLqR9oN51Hh
	NtHP/LG5OLPTaCpfymPpjikfAFuxKZQY1ibUd9aiW6nWO0qwR4/58MdFe3tcAhj/CFvNXPixdJR
	LFNTDDv3q7uocP5IGUflI0ZLpKTxxQ
X-Gm-Gg: Acq92OGUgRStuOenBtD3AoBmQ89AOzyml/o/kSgJw2r+r4AbceAeBTq/Iduww9S7h74
	Yi6R8yyebQspqgDw+QgdhVVFVboHCfCDtXJsBE+1euC4v6CC7byjUVQypd2t2G6iZOz7Kbi0KB1
	xcwUGI3N6GSuJ6aVNqsaOphi4KUJEItp6ufqYvy7Y8SolFLS5OxN3WUvtdFkU03UOEic88GhzqB
	v6bFrMcRBUId8L00y/Wm0wvIUcIeWycHahtzu4H8FCMXD/VFv+jR7nfsq1C8Rm8qIfUaK6ujcBr
	esDj2z61
X-Received: by 2002:a05:6000:24c6:b0:45d:b14b:23f0 with SMTP id ffacd0b85a97d-45e5c36754dmr3571852f8f.15.1778833126927;
        Fri, 15 May 2026 01:18:46 -0700 (PDT)
X-Received: by 2002:a05:6000:24c6:b0:45d:b14b:23f0 with SMTP id
 ffacd0b85a97d-45e5c36754dmr3571819f8f.15.1778833126577; Fri, 15 May 2026
 01:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
 <20260512011502.53072-7-chang.seok.bae@intel.com> <6adbdfb5-c4fa-455b-b427-2f8350bc9c2e@intel.com>
 <CABgObfZmFLDZPLEeLW5=yk8oyO8ibXr48JSVXaF7cKfz2SQw4A@mail.gmail.com> <ef605dbd-6594-4ddf-9274-c8ad9252f35a@intel.com>
In-Reply-To: <ef605dbd-6594-4ddf-9274-c8ad9252f35a@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 15 May 2026 10:18:33 +0200
X-Gm-Features: AVHnY4JXXiOwf_3bq-gWEX-sMBY1emblUdk32-d6BBum5qiZBABSRJfn6aPCPyE
Message-ID: <CABgObfaocwfLdUBKJYYYEDH8X3n6iEbMsscbaCe_C=8JNnhDBA@mail.gmail.com>
Subject: Re: [PATCH v4 06/21] x86/fpu: Ignore APX when copying from/to guest FPU
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 4:10=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> On 5/14/2026 9:04 AM, Paolo Bonzini wrote:
> >
> > Separately, it's possible to avoid hardcoding APX by passing a mask
> > argument to fpu_copy_uabi_to_guest_fpstate and
> > fpu_copy_guest_fpstate_to_uabi. KVM can then pass
> > ~(u64)XFEATURE_MASK_APX.
>
> Yeah, that=E2=80=99s possible, though it also needs to ensure XSTATE_BV[A=
PX] =3D 0
> in the UABI buffer to avoid:
>
>         if (ustate->xsave.header.xfeatures & ~xcr0)
>                 return -EINVAL;
>
> V3 previously handled that on the KVM side. Then, V4 moved it to the
> x86/fpu core to make the exclusion more explicit.

Based on Dave's email, I don't think any change is needed as long as
it's clear that the exceptional treatment of APX is transparent for
userspace. But let's wait for him to confirm.

Paolo

