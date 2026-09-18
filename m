Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7962ED154
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750594; cv=pass; b=UXL/DgfhXXsz6F/a02oEpp80SOEM99BxnjGTUmRezZImcu2MO4eo+Ra8Azegvg9/zmV5ajOBp5/AcThnNtieW2IaopSlbHanljVFCYOl9rdw6Da/KR9UXuty1s89toSVEhjnJV9uVRDQFLqJZdDrYnruxi7mzbNehOdG8i3iXjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750594; c=relaxed/simple;
	bh=Q77Bix35TqUYi11B20K9mAkgbUq61MX1Rmo97L+4Qmg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmvwLI9foIj0hp7/2L2eRFgxf7RbLUzbEIM4+rD4OSQzMXb4pMv/ekubzotLl0W4Dgmo6urcnBdsXpGltY/zGR51ZDl50uLaS+llapLPdYNudf/RfRKlyvqXUoFXeoRcnDt+sztF7pztobVBmLGzUZbJMJ/BE67+CEcD42RgiPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3sIW8dw; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3sIW8dw"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6eeso9873126d6.0
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 09:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789750591; cv=none;
        d=google.com; s=arc-20260327;
        b=D+HuAdt7mzJqVe/bAkcCP2oC6zk84wrjoQxJe7aRj1wFlEGWzxqqt3w8ocHqgEa+MF
         aPrsuSv8al+pGCsxSzTwlel1+2oOD2rmtMuQTbUoxIKjfjXnEMed66O7fXd89QGiI5kk
         Ht0mBeKrRQk7pxfSQKv3Amj/14m1/8UHVOdz+5YrFwUV+Btcgm/rN/OwLDfoTXOAszNU
         LJc3MQkYt1d9oR2Sswjiacpys3A1Mzro0pNunjFwnDOspglhcHtihf4CFLRkjkwdMWId
         rz8A0xPSbuw/+4NUlWnuWWowHBCRCd3UXrm9NDA442LwHnswKMACG88Sr0JjjxAMl4Lb
         F2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/3hfhz8Hbq1oioh3pabRNXznpcstGu9TRDyQ4WeUxrU=;
        fh=BiGV9gMYU2fK+GHeNEsbDHzxtfWbIdKlWk7jADF9AsU=;
        b=U2vda9Ozkvu/W9rRT3z8o/GDEde8riC3fCTM0HXRqOj2rCGIr1QS2AFL/vcx43km15
         500rYus21SvM7WLTqDVQoukiJkJWwglLF6xXkEm/Roo2tUxJBKHzqdHYVzbMo930DY4Q
         ASxtoDndc2AD2K0lO1NCtiXDiOS3GebREF6WdKwMjwYWh6p63aJxtQjARkCyPdSwTpvC
         4aBU6Py0L9OXDfi3cb3UQ3xZq91OnvEJXzvxw030N8lrooo046Vd8TK/8R4WI97K87sW
         3n16zz1I0QGrLNWsLHyrBSzgfZy+z/Jc1xUw6D5wWdi3ZLx/SHcZXpoLLHyM5WMzhR4a
         2mVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789750591; x=1790355391; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/3hfhz8Hbq1oioh3pabRNXznpcstGu9TRDyQ4WeUxrU=;
        b=O3sIW8dwAOuYU3yqDcKC0G7l7yMdHBuZLooleXZl5QovMyJiBjCLAg7vUhA35ezYJM
         E+8iPL+Jhg0tdn7xROi1gj53pm9RCEj5sjjgEdGOhm1bbwimwcJIYYqSwJPjpxD5tGdQ
         6ArmTvhioIym4dYCrPezcNLiIqmYuTvZGAtgWymZQL3q+PaeZZypUOmmnblUTZdBxhSO
         N+9Q+bK0basUCi/I8b/QPzWINAHq+eOp75Eyw60K+rZlrh0tk0dM8jybieTsJ20x0gJ6
         HRl55X2jV6S0kse6LVJYTsXTazPKjLFRjRnvdV/tk/vg/Zj+BaDW2vSSUQXecNigOlpC
         23RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750591; x=1790355391;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/3hfhz8Hbq1oioh3pabRNXznpcstGu9TRDyQ4WeUxrU=;
        b=ulY5YG76ZH37luB040XdC6BQPKaeJ31o6zLzLX46zUGbLGBVJSYHBg0xzi805snjgF
         3e+ZRxisVqEJ24Ha77ZRseiDTIR7F/0BaId8q97Q/tC25N8LFTGeSDA/6liqbGVI9Zfz
         farG0P3ic8e32VXEgbDFSEGlTI1QbJrG8VnKb3zbckng4dv2JN69jCCs4RAUB2eJyBse
         8Oc2Hjsh3dYWXYbD0b3YUiUs5cwwt4nXQdjlfMNRljfDz57b9/ENyn+1a+yORlAxIuRB
         4nyskEXHm76kIZ0PrgLjHABYre9t5mVtij+uy3p6S30h53tz84S2bdtRKOyB46OHKZUu
         PLAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxioalX9gUMBceIidLzqbiPJ3FjAQzmSOlGBbpLcvMgeF6iA11xfeePsaIzagdCs+r8cAY=@vger.kernel.org
X-Gm-Message-State: AFuF++nrvtpPNLahMvTb3H0M7hX066xkbu1qtv4W77wHf7i27tBlBtCP
	ek6D+wVfNp8spSWGbKvbDU9jJWa7jKo9LvYmBN3ML2ReU6vuYPwkxyieR5BblCpyaHtlvHZm289
	dTrgJ2RezBTMLfarCrnxVCeJFRklYOqtyUN7XhTFtto753voas+16CzmzwR0=
X-Gm-Gg: AYBFou0NM3H7hKCHVKMb3Umo2x4WU3CSD0LMShiri+MXB7G/9jmBVZDouhWngiFsB36
	PgGdE6vYCYmy3LDvMegsfJmS1KR7h+kth9n9B46fJ4dVCHQjX1X/UdXM0qnH8/xuvoONnkztoB8
	mFJ2H+sfWuhEaFh8PqHELcxD12SdMAvJSK0sG2iB013eWfVQBlQ0yobezpUqswYWtAWyPqdDHx8
	vQ2Z8jAu39L/NJJJ5iJKZxenWBFk1Qqq0SHucULT5EY7z+ykFWwmIw+2IviGesHewOvhM4HHpLf
	Nu1k3y/PTS6tHHjbj+FYAwdcq/B0/XBtmWq9hTYNeCb+/4+q8aKcVFpUsaAUH8a0JOYZGH9Lluu
	Sr95afpNLPkArWEyA6/U8MpiiJq1h+fy51Phhc5iSFQ==
X-Received: by 2002:a05:6214:83cb:10b0:90e:94e5:79f8 with SMTP id
 6a1803df08f44-91254b3cc0fmr42995266d6.23.1789750590126; Fri, 18 Sep 2026
 09:56:30 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Sep 2026 09:56:29 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Sep 2026 09:56:29 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aqw_uBIYig_uo5Eq@google.com>
References: <b91dbfae-20f1-4b9f-a25b-4397afae80f9@kernel.org>
 <16ffff40-4ef0-4312-a700-348603f05c0c@kernel.org> <CAEvNRgGW_VHmT82q+bUqHh_5G2Z9sUF1jJOTiVN4Z8_cA9A50g@mail.gmail.com>
 <aqw_uBIYig_uo5Eq@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 09:56:29 -0700
X-Gm-Features: AcwNN1X5D8x79th8tANMR24DjHce_J2gDtrs-KgBIrDOaE8qCS7M_N_lTAQKK6Y
Message-ID: <CAEvNRgGXi0U1gWY_m5aa5fW66fAXnU+3jw2sov3eykDzodvrvQ@mail.gmail.com>
Subject: Re: [Invitation] bi-weekly guest_memfd upstream call on 2026-09-17
To: Sean Christopherson <seanjc@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	KVM <kvm@vger.kernel.org>, amit@infradead.org, aneeshkumar.kizhakeveetil@arm.com, 
	ashish.kalra@amd.com, dwmw2@infradead.org, eberman@quicinc.com, 
	fvdl@google.com, gshan@redhat.com, jackmanb@google.com, jackyli@google.com, 
	jthoughton@google.com, kalyazin@amazon.com, kas@kernel.org, 
	kevinloughlin@google.com, liruxin@google.com, michael.day@amd.com, 
	michael.roth@amd.com, mike.rapoport@gmail.com, mvaralar@redhat.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, patrick.roy@linux.dev, 
	Peter Xu <peterx@redhat.com>, pheragu@quicinc.com, pkondeti@qti.qualcomm.com, 
	prty@google.com, psalian@google.com, qinkun@google.com, shan.gavin@gmail.com, 
	shivankg@amd.com, sidtelang@google.com, suzuki.poulose@arm.com, 
	tabba@google.com, tatashin@google.com, vannapurve@google.com, vbabka@suse.com, 
	wyihan@google.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Sep 17, 2026, Ackerley Tng wrote:
>> At the call Sean suggested mirroring the RMM's tracking in KVM, but that
>> sounds quite arch-specific and it's like doing arch-specific validation
>> within KVM.
>
> I suggested "mirroring" the tracking in KVM arm64, not in guest_memfd.
>
> E.g. put a structure in arm64's kvm_vcpu_arch with a list_head object, then insert
> into a per-VM list store in kvm_arch on a conversion request.  But before inserting,
> walk the list to see if there are conflicting requests, and if so, reject the new
> request.
>
> Then on KVM_RUN, if a vCPU has an outstanding request, verify the gmem page exists,
> is in the correct state, and is mapped into the guest (or at least, is known to the
> RMM?).  If any steps fail, exit to userspace with -EFAULT + KVM_EXIT_MEMORY_FAULT.
>
> The downside to such a simplistic implementation is that it'll require a per-VM
> lock to serialize the requests.  If the contention ends up being too painful, e.g.
> because there are usage patterns where guests due batched conversions across many
> vCPUs, then KVM could use a more sophisticated approach as needed.  E.g. shard the
> tracking+locking at 1GiB or something?
>

Perhaps naive question: What if, in the complete_userspace_io handler,
RMI_RTT_SET_RIPAS reads the vcpu_run struct and passes on exactly what
userspace said was handled? (Make the vcpu_run struct for
KVM_EXIT_MEMORY_FAULT bidirectional.)

Is the issue context switches? If the vcpu continuing the vcpu_run is
not the same vcpu that exited?

Perhaps userspace can track conversion requests, like on
KVM_EXIT_MEMORY_FAULT, save the request as <TOKEN>. Then any CPU can
take the token and do the conversion with guest_memfd, associate results
with <TOKEN>. Then on continuing the given vCPU associated with <TOKEN>,
pick up the results for that token and continue.

With that, all races and errors are for the guest/RMM/userspace to
report and handle.


>> p.s. Fuad, for pKVM you also mentioned that you'll need to check if the
>> guest had requested for conversion first? This might be the same/similar
>> problem.
