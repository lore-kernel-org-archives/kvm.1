Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3513DD85E
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670478; cv=pass; b=t54L4fsNxOq4TfMdSCXGKvRV0y+lEuvvTD4f+k6p+arCY96KERH6xcXlfndgQuM55Lxza0WO6crSLagd3GYaI/ALXiNe7Qv6wtZn2dlmqztYgwNzE5HjNLK7v0XH887odHB7T5UJeyrLVGpI0kgyat1+7xqalC+0BNlpJZODSjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670478; c=relaxed/simple;
	bh=scck5hHT95K37qHw+esH5ZRFCW0/ES6LCsTDUaeNHHE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1SdPFHFU1vKzqEYHcn156qWX7gdYc/pkdXs8F+lzGwaC3e367Z3wD9My9pAtTzd2GhoEVEe8EP4hbHquK4qslHpBCT2/GgQviZbyBXbpN9t6IcuAYH9KT2BxH204IfprKHFTvBxgw2J9eFfKfBg6cWgoa5gxXCOlF5Pmr7HrEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jF2+uV0s; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jF2+uV0s"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76ef1d0so9809641cf.0
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 11:41:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789670476; cv=none;
        d=google.com; s=arc-20260327;
        b=piijizxbdX+/BCGVMQfsoMCTioiczfunL2+y/thViscuhj00xtNTCbmVps2xMnVfgB
         qddG4hnG5+CU8Bk6qB+PrrNk2sz20AtQmJolytmIiMm1vZZvsP0Qi0wW5Wx7ThrX4/2P
         X41AOdrG0iiZPUi7k8mNGIG5eG3ovanDsAWJdSjrsFHjlrmmmg8//iR7m6GtNvvAA5wN
         8qsONOHaxReSdiuHTIiuK1NSRWEX32m+4K3IuCvc7xHwy1OoihSAAQr7wvGdtPECyGpn
         EqKmPC3n+wkLDovAXBt5vIBfZL/VpYkoVJWxRDlDqeyDC0P95A6R/xK+ChAT5c0Zo7/5
         OTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ELY/Vg+05/1vgJL6X13+cNWxT0fSTrqi1KeBJiACBOk=;
        fh=pN9weccSKJTvwb0y0OpxdhwRdcJhvNi9bbClgmh/lcI=;
        b=biokffB4qi/NWsBY+jZQKXdVaIDkSNrGZzuOTpLbnt76sYJgyqhg74fRoUWP+AqrgT
         Skvw9y9qNdht9rx1kbvCMKWihOf5zsDx1A8VodRAMtAEcUmJUJHRe7nWOsoP5wlqjtuD
         NqK+bRR5ANBJPsZY4WiZeH34EUM4B09t+oy2SAmEJxmQ0RG4txxFVUP58W1zlL24aNfB
         UrtT68JdbzUr9kvmjIWixlDnONNp+MfKbgxtyjg2SsJcV1f7FkJM4ErfS6EJ0qX9OQNb
         f7y6Cyc5zgMkomGc7LT8gvrbBi19h17Wbyj8ugZvn8br3/PDDBTK8nfLKHiC/rvbExdh
         2EUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789670476; x=1790275276; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ELY/Vg+05/1vgJL6X13+cNWxT0fSTrqi1KeBJiACBOk=;
        b=jF2+uV0sb4RoxmBNwASgflNv0f2DakUSf3VMsMaDtCTdWohsPNOQ8mz9Q6o1P1Oe+d
         fprXB0eGhLICRUqGhVzVilsGvfqK0m39xJoZ06GeTzxa5hN1cNLP0hWgw83FQU9JmBRN
         7gtbn9BnjmjaZfKJTPgsWnJxlYZD/i0oIebDmx1Yszsw8Np6casEXOD603Pb5kRcG55+
         e0aNhR74oVbLPw3l7q2KWvQtystsc5DxwTrLuDEEfY4EduE6AoK/VqdnxPlIBrULFZuI
         1CO4oqfcXzeHDRagqP+KceHBftSb15fOowqfAkWzLP1xSIxGE5qS3b1/zK56RD1U3h1p
         6Gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789670476; x=1790275276;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ELY/Vg+05/1vgJL6X13+cNWxT0fSTrqi1KeBJiACBOk=;
        b=1GWv/fv6in801D91fF2ajmevuEzvnxiWGsBEbENDKB4CPI5BDfgWihCWs8oE+oGRAK
         CO59EtXGk2w4Kxrk5Xw8j8TOEaRD+AQ6kd6JMWOZm1Q6Hn4em11Epy0K0sPuPgEqsVPu
         ccTVCEyeuIuEmkrMGwGydkc9ZnCkMOG9EQihLumuFrU3s6P2L0yAwZPB4SEC7K0RzN6p
         Jn7tojyJBGv8HBktBFrvadLY+D6hyQr2hASwebqtN6BjIxhsjrncUXrG4U6uFS/3zUeg
         JSMlEA9Cvqny1lHw/CczBfeC9BcQ8rcqaBIYo4gC1BnM5MMH9Qp27HT+qk6VIXOMWRmW
         ojbg==
X-Forwarded-Encrypted: i=1; AKwUvBzWErzNd+ei7Qonc7hZ9K63mFYB8RIyfHRvnHl/+1BQvyKpTFVM+x9wiXO8GvO6uWojN34=@vger.kernel.org
X-Gm-Message-State: AFuF++kgBomiS4RXMAP07jv7zkDRYz/KqL1s41mdGYso51RfONmlFmek
	nAP1Bx9ehj/gjLDIR3eEKLIitYEp1C1aKKGr69V7ybQMBigoRGzFdA3kxhUz+FoxVMQmXwVKKjY
	fI7FY8CExvFF0CAV5PS4ymt4jjbRTzu4oiPzWCt4I
X-Gm-Gg: AYBFou3m54sgrwy89PQDDJbqgckd5+fl5L5iAXXmEYGY3kEhHa6jTPjkvmZsKfh60ju
	Y/5v0s/j653/3ukUU0AFB9cxeSulBslMBuDYdB99ykDTNdsv0KixSDCmzJhyUFY/CRgcnFRjKao
	ifNqqxu7p5REmZn7plYuvUq75I81QTQIXoQgI087l2mvNOvOk657FIAUaLVXGvvri9AA11RaSBm
	uPBzauaQW5iqohtck847z1aumS7Ne+hxJkVoZ4Z84thtrs9nPIsKhCR38VcHPcq6Yr9BVFxKO/N
	wGThJCoRDnYTxu5WpX0DqPKgwNDdIO/oLGTbJSpzimw/dkNkKZFvQSYY8Zg7xFHX2cIP/2u+Q5v
	P56YsajskNpTAFWni9R7NGhg1OA+I7hfgMMgnK8QWFcXNTJ9YGDqK
X-Received: by 2002:a05:622a:6090:b0:530:b2e2:903c with SMTP id
 d75a77b69052e-5329e3d0db2mr1678821cf.60.1789670475157; Thu, 17 Sep 2026
 11:41:15 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Sep 2026 11:41:14 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Sep 2026 11:41:14 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <16ffff40-4ef0-4312-a700-348603f05c0c@kernel.org>
References: <b91dbfae-20f1-4b9f-a25b-4397afae80f9@kernel.org> <16ffff40-4ef0-4312-a700-348603f05c0c@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 17 Sep 2026 11:41:14 -0700
X-Gm-Features: AcwNN1VH2wWa1-by0xZw2bG7z5QRI7gmGmYcIKbpxNe1NiOi-7X0KO0Bg2xGucg
Message-ID: <CAEvNRgGW_VHmT82q+bUqHh_5G2Z9sUF1jJOTiVN4Z8_cA9A50g@mail.gmail.com>
Subject: Re: [Invitation] bi-weekly guest_memfd upstream call on 2026-09-17
To: "David Hildenbrand (Arm)" <david@kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	KVM <kvm@vger.kernel.org>
Cc: amit@infradead.org, aneeshkumar.kizhakeveetil@arm.com, 
	ashish.kalra@amd.com, dwmw2@infradead.org, eberman@quicinc.com, 
	fvdl@google.com, gshan@redhat.com, jackmanb@google.com, jackyli@google.com, 
	jthoughton@google.com, kalyazin@amazon.com, kas@kernel.org, 
	kevinloughlin@google.com, liruxin@google.com, michael.day@amd.com, 
	michael.roth@amd.com, mike.rapoport@gmail.com, mvaralar@redhat.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, patrick.roy@linux.dev, 
	Peter Xu <peterx@redhat.com>, pheragu@quicinc.com, pkondeti@qti.qualcomm.com, 
	prty@google.com, psalian@google.com, qinkun@google.com, seanjc@google.com, 
	shan.gavin@gmail.com, shivankg@amd.com, sidtelang@google.com, 
	suzuki.poulose@arm.com, tabba@google.com, tatashin@google.com, 
	vannapurve@google.com, vbabka@suse.com, wyihan@google.com
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 9/16/26 17:11, David Hildenbrand (Arm) wrote:
>> Hi,
>>
>> Our next guest_memfd upstream call is scheduled for tomorrow, Thursday,
>> 2026-09-16 8:00 - 9:00am (GMT-07:00) Pacific Time - Vancouver.
>
> Sorry, tomorrow (17) of course :(
>
> --
> Cheers,
>
> David

I'd like to try and restate the conversion problem we discussed today to
understand better :)

CCA's conversion protocol is:

1. Guest tells RMM to convert a GPA range
2. RMM notes down, in a vCPU object within the RMM, the conversion range
3. On re-entering the guest, RMM tells the guest if the conversion
   progress, something like:
     + success, GPA start to GPA end was converted or
     + failed, (with some error?)
4. Guest can
     + Be happy that whatever it requested is fulfilled
     + Retry to finish the parts that wasn't yet converted or
     + Be sad that it failed and figure it out.

I looked more into it and I'm surprised that what I was thinking of as
"tell RMM to mark shared" isn't even correct.

RMI_RTT_SET_RIPAS() takes these parameters: rd (the realm), rec_ptr (the
vCPU), base (GPA start) and top (GPA after, or base + size).

RMI_RTT_SET_RIPAS doesn't even take anything about shared or private!

RMI_RTT_SET_RIPAS() is actually saying "host permits the conversion from
base to top", it's not telling the RMM what to set it to, this is also
different from SNP.

Interestingly RMI_RTT_SET_RIPAS() also errors out if the current
shared/private state is different from the one tracked in the vCPU
object in the RMM? Did I get that right? I'm looking at the base_align
Failure condition, where it says ripas_pre != rec.ripas_value.

If two vCPUs race to convert the same range to shared, both vCPUs would
have rec.ripas_value = private. The first conversion would be fine, but
the second one woul see ripas_pre = shared but rec.ripas_value = private
and would definitely get an error?

And there's no "accept" step in the guest after conversions, which makes
it different from TDX and SNP.

Difficulty in using current gmem hooks that SNP uses:

* .gmem_make_shared() called from conversions doesn't have the vCPU
  context, finding the right vCPU context is expensive.
    * Sean, don't we already iterate vCPUs to find VMSA pages to kick
      the right vCPUs?
* .gmem_make_private at fault time is too late
    * At the next vCPU enter, the RMM would already read it's state to
      report success/failure, and there's no fault in-between for the
      .gmem_make_private to happen.

At the call Sean suggested mirroring the RMM's tracking in KVM, but that
sounds quite arch-specific and it's like doing arch-specific validation
within KVM.

p.s. Fuad, for pKVM you also mentioned that you'll need to check if the
guest had requested for conversion first? This might be the same/similar
problem.
