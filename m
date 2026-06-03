Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F573563E8
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504389; cv=pass; b=d9CykgfzGoGynAyXgS4/aWLKvtXVYDT1Kbl2htF/0yzNPiAlflt4cQmja3eqDmAimoXqH2wuMaWjrtPv2Pejt9NPMyoQ6pMnG36LO7gMY5G8DmoByY0iqEff85DW09mfVFf9Z2Jn36wkiAzPjq796SZb91j9EfOigDxNi19/fdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504389; c=relaxed/simple;
	bh=ZxPkRCLPdwYvE5wVv13N/w4GFCh3fcUHpcgVy3lddVA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dm+ARqSjoNBMoovFUfGVvO43opI7UVEjMpog7sZUCRusCtz1oe/ctno21EDsCK9iWoARQNI7wDxKhS0Vi69hP1dUCb5q9tNDGGE+MnOa6HYf+q3uldvs8cYwT2Ihrd0asJL3IkPPRRyI6yckUz59yyIx14Ua0rk2BRIdaHUhqG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kU0h2XT7; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kU0h2XT7"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304e83724bfso7788926eec.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 09:33:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780504387; cv=none;
        d=google.com; s=arc-20240605;
        b=L8395p1f6+tcp8A2BqZqyGfseVEn/Ph0nJWVOV9Q5OeB63dirR9B7zeTZXZEwCaYmd
         WqakSgpsY3kryaRLUHrM3FXPruxslO5y21LGEka2vhaF5XrFHXhE4Vnx70rZeItP+M0+
         yHh69GrPIwVZPGfAyGPtuqCwbyix1P1xpKW4zxf3fd+NNFUxqxxNwJZh7/6rIJxuKHtC
         x7+vP2qsdqaorTAoJFUrwgWOHOLlmxPeyVKgehqMqiTy4mWY9kjowECMLL+0adh7DuBP
         rbEk/TvMBt8Kn3tu15tHRj/pW+5Sc78rBV31TnGMJGPPe6Wn5mtLMBttSC8bYk3YpPqF
         MhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=Ac75VsX3g/JvZKVcVDB50QISY1fBI93TsemytCxfqQg=;
        fh=KVy4+j+TE0qJlGnL1oxDtQvAs+ZlkPteDJwxhHS2piY=;
        b=UCN5WEDGFj/OydUKmfqovMTq4qTAMBB4xQaRmupUdNiE8GqMzyfn4Yk+9Yn7RPJ/qK
         hua90roCvqr809KgG4zQgPexB7KWVw1AjOxlTySWQHWw7VnVBshJCf9OJXnt923hBLPp
         tnIOzdGrbUYi0u5zEqtJbHZwzajMNeytFhUSs2AcHoszFl0Ips27YZj12+CT5TmUhMkN
         40P0u9/bW7rZH34UONwd+GilpfAQFu7BGRyeYeS1dNYD8ZjZf2haOiStX3OvCAn+kOqz
         cdhYmAyQC6RWRY4RlA+Pu8cD3YW79OUR4djrlPgr/AdnqFgDgtdEQKY8ZlidaMri6wWe
         4YmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780504387; x=1781109187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac75VsX3g/JvZKVcVDB50QISY1fBI93TsemytCxfqQg=;
        b=kU0h2XT7COeUfZnqhh6JDY6vSTH9RtNIavVGCVe3q+F8iuGbwHPodv6Cr2i06PDYgk
         OHfMHLGZDsF3Stf1N+hTzskH4qnThcRkks6d07dX3ibERn4IjpOaV7rYGG1nsnatWKvH
         EL6wOs7gIBuolUAm3SZaYWejka6ZC0Am9xZiGcxuPUu4M5VEszH6U4z2k4nDii/bg0fu
         xD2zlfO9glchx9lTsLe+yZsVTukxbvD2tKWvDe+C0aX6OceMYnpzKKFwbMy2Of8ASMWR
         83l8R2DnJL2c/0EpM+OIHVGnn6YZ+F6005W88zWzAa7d6Iql+AKKj24QKqu+0DiHFLWG
         uc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780504387; x=1781109187;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ac75VsX3g/JvZKVcVDB50QISY1fBI93TsemytCxfqQg=;
        b=pv1Gw/PoxV92FIm9IXIBajn9vI62k1KTSdqveJyM2JhZ6w0JIpKmfbMYsO0NSbsAfB
         bqYN835zZuEfmubmItzy6hA7cD+LcG5Lg9+A1+ZS5/BX/2S+mRCAwdt8yBmc6atD+jH4
         ypEpb2gzEccGVpZD0AK6tBAkoWuSbeYeCm8y2WkAQuYtcKuSDR0uWgNQsaZh0Sk9N8uK
         +8cPkhqZnElsp9JHYLPx3CFyrYfxxA6XI41qwbS/Y/tnYXwOSyRqFMMBARK4ckZHChVQ
         eVGN/0vPLOd/vSqgS6OYUZons3MOwXy1//lUFj2LUo6ayPdZ7ZCIyeJLfyuYaKzb9BR6
         gwUQ==
X-Gm-Message-State: AOJu0Yz0HYS99WOPa+99otQ2UTN8DIdFM/bONyRIlUhj1NSHBvxyd8JN
	v38MFkGkp5rhNAhorRexxs1nBG9pdcdMu2R6xAndMqlqy1nZPEjLlCV6V0/pp3EaXwh6D/pBJhc
	kIuL0Sr24+Xqe/SYLtAH69bVmzcM94wgjA6TRCCYTmJNwZyAEOxUblioW
X-Gm-Gg: Acq92OG+Us+KZ0vvV1xJyhIvM0FsO/gOC/3+JGifsSVaMgAEs8AR7L6aDpfZ8nj7+XG
	h7dDlD2HgEvc9akcqrII1iJLgRu4jxlbPXxgOb9Eqhcx4dWr+b+Jizrcl5Mg/HDTg99P0Kllj8J
	76zEr37q1UvPghvKWUFDl74LiQtStU1UpXp2oxZJtFfGbFQ4IfRA+2E3BUU4rwngm7XY7QSpC/j
	izmn10puUEqvhL8oDFyBPPu/xqZbtu9yo2ymWdH1dWsxOIknVTjsqYI8c4FfnSmJHFNCBZUJCMa
	Rkla3ybMbHysbqS7vUc1rGaXmZNy9AqLPo7dgge0RHf+v3+ip2g0N6JTBEtI2B+GT8HjF5wfpvs
	mjA==
X-Received: by 2002:a05:7301:100c:b0:304:5a9c:644c with SMTP id
 5a478bee46e88-3074fb04f07mr2172446eec.15.1780504386326; Wed, 03 Jun 2026
 09:33:06 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 09:33:05 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 09:33:05 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260523004223.446AF1F000E9@smtp.kernel.org>
References: <20260522-gmem-inplace-conversion-v7-26-2f0fae496530@google.com> <20260523004223.446AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jun 2026 09:33:05 -0700
X-Gm-Features: AVHnY4JW2u1ZtWpSbetCl3rrz2ZqMMas87ECOInjSalJ6zcCgQyc1sNDL8XEXxs
Message-ID: <CAEvNRgFrCYEzX8jtbhwTj3qRqo-_CZ1=F_v9H231UC6uY86=Fw@mail.gmail.com>
Subject: Re: [PATCH v7 26/42] KVM: selftests: Add helpers for calling ioctls
 on guest_memfd
To: sashiko-reviews@lists.linux.dev, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] The size parameter in `vm_set_memory_attributes` and the new `=
gmem` helpers was defined as `size_t` rather than `u64`, risking silent tru=
ncation of guest memory sizes on 32-bit platforms.
> - [Medium] `gmem_set_memory_attributes` invokes `kvm_check_cap` directly,=
 which incurs heavy system call overhead on every invocation and incorrectl=
y validates the capability attributes.
> --
>
> commit 89dd80303d47a776c6d340afaf265966a073bd73
> Author: Sean Christopherson <seanjc@google.com>
>
> KVM: selftests: Add helpers for calling ioctls on guest_memfd
>
> This commit adds helper functions to kvm_util.h for executing ioctls on a
> guest_memfd. It introduces standard macros like gmem_ioctl and functions =
for
> setting memory attributes. It also refactors supported attribute checks i=
nto
> a new TEST_ASSERT_SUPPORTED_ATTRIBUTES macro.
>
>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/test=
ing/selftests/kvm/include/kvm_util.h
>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> [ ... ]
>>  static inline void vm_set_memory_attributes(struct kvm_vm *vm, gpa_t gp=
a,
>> -					    u64 size, u64 attributes)
>> +					    size_t size, u64 attributes)
>
> [Severity: Medium]
> The KVM UAPI structures like kvm_memory_attributes use __u64 for the size
> field because guest physical memory regions can exceed 4GB. Since wrapper=
s
> like vm_mem_set_private() accept u64 sizes, does changing this parameter =
to
> size_t risk silent truncation of guest memory sizes on 32-bit platforms?
>

guest_memfd is 64-bit only.

>>  {
>>  	struct kvm_memory_attributes attr =3D {
>>  		.attributes =3D attributes,
> [ ... ]
>> +static inline int __gmem_set_memory_attributes(int fd, u64 offset,
>> +					       size_t size, u64 attributes,
>
> [Severity: Medium]
> Will this size_t parameter similarly truncate memory sizes greater than
> 4GB on 32-bit platforms, causing the ioctl to operate on incomplete memor=
y
> ranges?
>

guest_memfd is 64-bit only.

>> +					       u64 *error_offset)
>> +{
> [ ... ]
>> +static inline void gmem_set_memory_attributes(int fd, u64 offset,
>> +					      size_t size, u64 attributes)
>> +{
>> +	struct kvm_memory_attributes2 attr =3D {
>> +		.attributes =3D attributes,
>> +		.offset =3D offset,
>> +		.size =3D size,
>> +		.flags =3D 0,
>> +	};
>> +
>> +	TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes);
>> +
>> +	__TEST_REQUIRE(kvm_check_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES) > =
0,
>> +		       "No valid attributes for guest_memfd ioctl!");
>
> [Severity: Medium]
> The kvm_check_cap() function performs open, an ioctl, and close on /dev/k=
vm
> every time it is called. Since gmem_set_memory_attributes() might be call=
ed
> repeatedly in loops over multiple memory regions, will this incur signifi=
cant
> syscall overhead and degrade test performance?
>

I think this is ok? The part that concerns me is where we test for
races, like in x86/private_mem_conversions_test.c where we also use
gmem_set_memory_attributes(), and if doing open/close on /dev/kvm causes
false synchronization somewhere. I don't know of any false
synchronizations and I think this is fine.

> Additionally, this merely verifies that the capability bitmask is non-zer=
o.
> Should this perform a bitwise validation against the requested attributes=
 to
> ensure the specific attributes requested are supported, rather than passi=
ng
> the check and later crashing the test with -EINVAL from the ioctl?
>

This part is intended to check for presence of attributes, the validity
of the requested attributes is checked later.

>> +
>> +	gmem_ioctl(fd, KVM_SET_MEMORY_ATTRIBUTES2, &attr);
>> +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inp=
lace-conversion-v7-0-2f0fae496530@google.com?part=3D26
