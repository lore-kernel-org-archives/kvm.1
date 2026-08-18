Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1734BA20
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087031; cv=none; b=I4ad2Zw+Y9ZbR+Ui0mq0cI1u7QZoMJbBKqhift5aE1VVnX7uOg8TWq8mhzU/bpDuV9PSdwdJ6qgPmnmpjYIhfL/3hvHvQ2v6OBLWdCgZn9LI+KcwjS8J1YVEZ6MKLy3eiBRPLFHL+RoK69adZoCA+3aMzjo3uZxT9iV/M7dfJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087031; c=relaxed/simple;
	bh=VA+SIcF2JEQ1JJLvPSrWTikAbsMHIebPPodiINRMPV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcYZRZGx19NYtf2/GyuZSpW+d4/nvLpkhXolBQiNRm+0UHNFYxdWivL+vVZ2KFBjsAKPRXqugZLbcWDIjQCr8R1gLQ3F1tIJqOxWyEfyWmHiYeJgh0t37uG3J7RBGdJAGw34MAxQHADID9cqAEFWo9DSyL4ZwDG4UCATioyuT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBeClpjU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBeClpjU"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49558ce01afso2447555e9.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787087028; x=1787691828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87Tocz7iX4zZzqPz4Y1pLylVtSGOpYwXIbfhErO8dNY=;
        b=mBeClpjUZzZGksKQ9xoJy7BBE1z10rGmAOMt5n8pzMLBvQ7KIKVMnFwg7A45ut143f
         LI0kH6eZbru670VTIB5k1Tq3Ttc1LoODK38KHQ7DtHuMqlasgRuOV1nE58TknF9edUOq
         wxvB9E9QOQB9BqrTVArZUmaQCZ5DpdenRMcx89K+0HOYxCcR2gOX5MnpbPxF0oNPzqKi
         4hncVX7YuAhw25GVP33tD85knadvXerZJ3QXUhRP7KN+jbuHJUtejApxTvt54cJIf59l
         SoHMtFIuqxvqIDpzZUJ6fLDUOatvHO+gVexqhccSIL8hK8Fe65y6XU8XdxTQRFc93Fsp
         EaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787087028; x=1787691828;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=87Tocz7iX4zZzqPz4Y1pLylVtSGOpYwXIbfhErO8dNY=;
        b=ri+Q3UiB/ohBol/AmIvUeCNgKBYA8ndrCVSRoldgLaewXc2Ot8pOxQ5N/KrepAEyY+
         UWEgskSoo5SKIqT/w+oF0fxvyFk8pTTMW+oJVlCssBvg/1Zf3xmelsBfPLziDkU1hlAn
         maMuTvuvcmsNnyD7JITUMIeNrSejRlqxRcpP4k1yo7rLLW61pz05BLl/zxo3x4hztYra
         VWPhgLNo+AvRASK8kIidfSO+2uqO+0r5Pu2sILPhV5ezqOfdUinmEj2rGJ7ff76b6YoW
         J3xmKetrLy8J2U96Klai39i8VXE4WUkEFLYD0twig0Od1aVUsmNu6Wk3FRdleXdVRODD
         33Ww==
X-Gm-Message-State: AOJu0YzHmb7tku/rFlyAYySvtZtj6JgfRLN3vf4B3trA6Be3DlXknc0O
	4UfAxblln+ZsAH3EftQGR0PZbCkNCBlke/mASv+scOx8nIClQI/R2r1D
X-Gm-Gg: AR+sD103upUPgHe7R3axMZYpnSE6ON3kmI7XiLXWpkm2H4SEhA+whPNHwWggwYMNq3I
	ERYEjNxAydhzDvxn6SOVs85mzAmM3bye/KSQIq5//SuI5rBxnh8upXKxLn3hujn9tJEbBMrsQzy
	ktojOR1Cc4NIU8nULp1ePxcJQuG5TpSEJqUsDBkxGEcnkjw2RseJQGVKdzhxRjFt7kRga4g7N1W
	H4ogtkrroVxXdoQK25Iq8EMWiQI+hUFk1Cbl5PaGv4j8iYv4CF9CHWJkHdMHwchbEoGHn46uPBa
	sKocJlrQRbki1M0nnCnvlZhFBIKzJJEmY9l17a1lXLN78r3sRJli7ut8kvF+gsf5s5/X6IyoO7x
	6/I4q6NC4Yd4HriWekFyx9hFcv55K4kVCm7tUoYcDiWAGs5Ng6T02Nr8V/9LyLnlnLTNfUUoLwu
	31vj6Bqc8tAIsapvytDxh1TycV3EdrwNRnB7aJ/GTrqBXTfoRHSMVTedGDA+d5u6L6bOnzUyDIz
	GbqpU7vsdSuoGME31dfatdRyp1bjHdN8cFgVWKjpei5N3D+3tesfDOiwxKbMXPKHQw=
X-Received: by 2002:a05:600c:348b:b0:499:5282:f8d1 with SMTP id 5b1f17b1804b1-499a8fcd890mr14141845e9.12.1787087027805;
        Tue, 18 Aug 2026 14:03:47 -0700 (PDT)
Received: from ?IPV6:2407:d000:508:2027:311e:5c97:f108:813a? ([2407:d000:508:2027:311e:5c97:f108:813a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9e09905sm2711825e9.4.2026.08.18.14.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 14:03:47 -0700 (PDT)
Message-ID: <c9ee5f08-81c3-4c91-9189-002b260ea641@gmail.com>
Date: Wed, 19 Aug 2026 02:03:43 +0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: selftests: Replace ulong with unsigned long
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, David Matlack <dmatlack@google.com>
References: <20260803170825.925561-4-hisamshar@gmail.com>
 <20260817220457.554823-3-hisamshar@gmail.com> <aoOKMeua-cNeTxXT@google.com>
 <8d069fe1-a5b6-4a86-9604-26aebe2dc243@gmail.com>
 <aoSIBnFfy4osa6wt@google.com>
 <c2f7e904-2646-4b01-864d-d185221c7f56@gmail.com>
 <aoSyYtxBpEaoBwGY@google.com>
Content-Language: en-US
From: Hisam Mehboob <hisamshar@gmail.com>
In-Reply-To: <aoSyYtxBpEaoBwGY@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/26 00:28, Sean Christopherson wrote:
> +David for the VFIO thing
> 
> On Tue, Aug 18, 2026, Hisam Mehboob wrote:
>> On 8/18/26 21:27, Sean Christopherson wrote:
>>
>>> Oh, so on top of "https://github.com/kvm-x86/linux.git next", this *is* the last
>>> blocker?  If so, then I'll grab this for 7.3.
>>
>> Not quite -- I tested kvm-x86/next + this patch with musl-gcc, and the
>> build still fails. On top of the steal_time fix already in your tree,
>> two more musl blockers remain, both from code that is only in
>> kvm-x86/next so far:
>>
>> 1. hardware_disable_test.c, from 496779b54943 ("Pre-set threads affinity
>>     in hardware disable test when possible"):
>>
>>       hardware_disable_test.c:75: error: implicit declaration of function
>>       'pthread_attr_setaffinity_np'
>>
>>     The call sits under #ifdef _GNU_SOURCE, but lib.mk defines _GNU_SOURCE
>>     unconditionally, so the path is always taken and musl (which lacks the
>>     function) breaks.
> 
> Heh, Sashiko flagged that as problematic, and I was trying to figure out which
> macro to key off of[*], but was (obviously) unsuccessful.  I don't suppose you
> know the canonical way for checking for support of glibc-only functionality of
> this nature?
> 
> [*] https://lore.kernel.org/all/am0KqJOD-FiC9BXs@google.com
> 

__GLIBC__ is the pragmatic in-tree answer.
_GNU_SOURCE is a request macro (input to the libc headers), not an
availability indicator -- lib.mk defines it unconditionally, so it
cannot detect anything. __USE_GNU works but is glibc-internal.
__GLIBC__ is defined by glibc's <features.h>, which any libc header
pulls in, and is the established idiom in selftests already:
kvm/lib/assert.c uses "#ifdef __GLIBC__" for execinfo.h, as do
bpf/test_progs.c and nolibc. musl deliberately provides no __MUSL__ --
its FAQ's stance is "test for properties, don't assume them", which
strictly implies a compile test (autoconf-style); with no configure
step in selftests, __GLIBC__ is the established in-tree idiom. For
hardware_disable_test.c that is s/_GNU_SOURCE/__GLIBC__/ in the three
spots; build-tested with musl-gcc, passes.

>>
>> 2. The libvfio wiring from a262fc49e0aa ("Build and link
>>     selftests/vfio/lib into KVM selftests"):
>>
>>       vfio_pci_device.c:25: fatal error: uuid/uuid.h: No such file or
>> directory
>>       sysfs.c:31: error: implicit declaration of function 'basename'
>>
>>     The former adds a hard libuuid dependency (its headers aren't visible
>>     to musl-gcc here);
> 
> Can you elaborate on what you mean by "its headers aren't visible to musl-gcc"?

musl-gcc searches only its own include directories
(here: /usr/include/x86_64-linux-musl and gcc's internal dir) and
deliberately not /usr/include, to avoid mixing glibc-oriented headers
with musl. uuid/uuid.h comes from libuuid (util-linux) and is installed
at /usr/include/uuid/uuid.h for the glibc toolchain, so glibc builds
find it and musl builds cannot. I see 2f0c30d0d1 already limits the
libvfio link to x86; the remaining gap on x86 is that libuuid is now a
hard dependency of the KVM selftests build (libvfio.mk adds -luuid),
and for musl-x86 the header is not visible at all without a
musl-targeted libuuid install. A uuid.h compile check to skip the vfio
pieces would keep it optional; otherwise the new dependency is probably
worth documenting.

> 
>>     the latter because musl declares basename only in
>>     <libgen.h>, while glibc exposes it via <string.h> under _GNU_SOURCE.
> 
> IIUC, sysfs.c just needs to explicitly include libgen.h?

Yes, adding <libgen.h> suffices. One nuance: there are two
flavors -- glibc under _GNU_SOURCE provides the GNU variant via
<string.h> (char *basename(const char *), non-modifying), while
<libgen.h> provides the POSIX variant (char *basename(char *), may
modify) and takes precedence on glibc as well. Safe at this call site:
rl_path is a writable buffer filled by readlink() (no trailing
slashes), used once by sscanf(). Verified with compile tests on both
libcs, and with <libgen.h> added, uuid/uuid.h is the only remaining
musl failure in the whole build.

>> The rseq __GNUC_PREREQ failure is already covered by my patch in
>> linux-next. With the above sorted, the musl build passes.

