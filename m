Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16746AED1
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626528; cv=pass; b=uNDu4zEmaRGhIzXs/ibiLN4fKr0HHHRZtk8rsGrY5rjWtoFvN6V2XFFPKko8rwD2/JV2vlSEJiADQVPRHrfZGpTVzhL6jMJGKkeANXxJRMsvVSaGhr0YGILglmpKbAxVq+zEC3mh7Se4YMioW8UyK25Xjq6AH2P4EKcFJHXcwtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626528; c=relaxed/simple;
	bh=DDdeKaR8U8RPFe1zDZcNqCeadhs62T3BN0SHD5eW/GU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgVCJvFF5zbT+UY35DgxFbyJ29a5u+bkReAQ4b63azT2EMOmc2x4QinBXS8MorKk8bBb+cKtf3BKP6IyIGlVOhMWBa/jYbtB0jnY0DvIb6heQfsBxM/TFp9CclVOA7v/zQ/GZlckvcSrXygwh5FPNn5fVqT94ZSnZs+aZfJmCE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A7LdVUh+; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7LdVUh+"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-138501f8c04so2443179c88.1
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 09:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781626526; cv=none;
        d=google.com; s=arc-20240605;
        b=KbVBCij4GiDnDV7bH2mB1s9Ut/JOIPsNI0QLFINmS4p5D1j6E4EymNIXnl+Up2c/2q
         XhofQb8/5C2wZQet9TUWb2sgtmnG+mY2avsS1ZUVNuovqz9lbi5A8k1THmsQ129a0Axl
         WrAmPJBJi2iftIK6M/kJkaigBVRzjbuAxaaSGI8oDlycf0g6F0O3CP8bpAcmfxBoqm2f
         sDISkyXrV6ITGjhwuq7WF8trBLWlzprKQzs69I3qfa+I4DXlAHBKUlRFzBHXQJVeWI93
         WTDcgjJOmGa6enGqPaSOo3AJYTL4eSZyT8LF+niXU1beL/+BhvUWfuHklaO2QiVYptng
         pSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=KxrAh3gZox9w5915Zp8CYh2ybM8dKM0MmMGgcGgqfcQ=;
        fh=TN04SSToW+iobU173LbhYJ9mtwUwgIa/wFz/jzOv2aY=;
        b=Jl/Xvk/kpF8Mpm0LiK7aQ1M33q6f+Bdt6ER5Wx63SnC66CepT7+ImoHhzbHeaeIyfU
         T8neEbS5u+/czLbBtSzPP8vqct2pRnNXVBFlyP4eRxijyw/r9avFx4ObEE3EnALWNvY6
         C6UT6JpkQ+1g62BtdtiJS9Li6TihI5bLIT0S5yfkUjYt1KO6TubsM19AAXpfUXbu35sT
         uS1OKkmQoaHgiKBkwygbP5T67Tkz3VrJdXDE3jzvTpL2hDGD2317Skj4nH6qDt9xPmP0
         ptyCWYHPvIzPjaDbMQSThli7u56BRRSkNTLIvKp9J6vJdWdVTFCl8tAEh5FYdEDOPbvy
         AeuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781626526; x=1782231326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KxrAh3gZox9w5915Zp8CYh2ybM8dKM0MmMGgcGgqfcQ=;
        b=A7LdVUh+UXJ+lCSBYtPGe9JYneQHnT4C26GHLQ6K/nZSJoyz3I0gyvA7+Fpfj7U/k9
         wKmXwLQysrovCup5Oq5ZXTlPvJ3q2DvsRgWaJ7MPAXhoJR/YfkK65ugP1kzgVzKIU09x
         CHPplxMYPHMbax0c32tTnN6wUE0s/+1wiGhQ0C+ce7eNYmJd/9KBXek+FILD26Lj+Vs7
         go+yUer+q5q0Oq1s3owqpXgZfhbJWVwhtaN5CnePqXFKfa/mFuONrR/NaWcyC/Ylt1gU
         4MiiYHNxBPE5G94S0oHIiWbuqZLPPgzXHGJr5avxR7kxsdG2mh/hhhUT63m2D4lUJYiQ
         W99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626526; x=1782231326;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxrAh3gZox9w5915Zp8CYh2ybM8dKM0MmMGgcGgqfcQ=;
        b=On5GNpuUr+4B/vHIlmYErxCFYwdbOKdyOfgMzOi0Yqs5kznplZp9naoUmQfEVwPQWa
         XHyDqjNDoF34NtIR0/Hq/d3XqMu/aos0uUI/RVFV5HJf0/bWdyO5K2s3D/hLfw1Exw9o
         9iOTVsLsGCQ+MAQ4wnWXRsZe7MGv6SjCHxpwGgC3sGrVvL0j3/QE2Ha6yhRoWPBwXrTw
         FEvk2UGLJj7kieqIOd4JNFH5I6ud0911Bk4ErbGMTLFdQd3rnsY15vSwmygwbdZdzcs/
         HgWVLzQIk2bjBNYWtlpSzy5EudX+Qv2tnZtMuk2Wl/KE5w/s8PTJ/+UhmeWEDeyhjz2i
         RcxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DqnSpgdDBrhmzU8ZhQPwHvcrfM0GWuaprfLe57ot3TZEfYSKKiYu5XvFK5x3EO//dawo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLy/HVuDt5fxKNcQx+YCVo0Uu24HRifZLkeER7GeQNAnmhyPaD
	jMyCzd0ynHCqU/vvqaHXYz2iYBLOvSoYufcga251pnDaSyzKuWELf+DjqcpxMEaYJElaiNLyGhv
	HuJXYhLaqc6B4AlWSoteyrucB7ZPUvBarQAEjPlCa+1v29oNrpqw0F78b
X-Gm-Gg: Acq92OGwcc2Q8GMmAG/40F3abaGm1ncnHMEMphdS3rFY+JhS6BQZapBlalD4iZ0ypfi
	m2eb/bp9Uf+LH7aSierLk2s6EuPS3QR2bppZFdtdAXYOcc4lMwXyiS+iBqmzcRQehcM/U/UWxs7
	QRhY9F2OlEVW9XNVpRlhuhA5FBGq6q3vkq8dsaoGc4G485gk+HsJlVj5k1WRAR66u7Xn3xZ96NL
	2IVDxf8opdsNekmRdm6Fr52y4ak48UOj67Qb1MUw5s4HLMIQnkYAdxR3rENskAk1Qbyze4RlLh9
	9mILkw6KVCk9uo8h+LHJEGsV/BZ2T1QSwRQ0ZZ4pQ9p0xiSofBmOOneKnz1qhdZziu3EHQ==
X-Received: by 2002:a05:7022:418:b0:137:fe07:8a2d with SMTP id
 a92af1059eb24-1386f24121cmr7479488c88.6.1781626525576; Tue, 16 Jun 2026
 09:15:25 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 09:15:24 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 09:15:24 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aiycmwMbhWuYghJh@google.com>
References: <20260331194202.1722082-1-vipinsh@google.com> <20260331194202.1722082-2-vipinsh@google.com>
 <CAEvNRgGrPKBXh=VA3QBLJOczKRpMOB4nDmZL0XRwV6B3PT_7+Q@mail.gmail.com>
 <aisHySKe0PwM5DSg@google.com> <CAEvNRgE-qt8DAjOeE5ANpXzrgEKs+2_wh4YSmY=pe6krngBXqQ@mail.gmail.com>
 <aitbveI2Sdx4s4BP@google.com> <CAEvNRgFLnGkqvvks3joAwPjqLz=ATmqiS0UWk71g+YEsxNsfsg@mail.gmail.com>
 <aiycmwMbhWuYghJh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Jun 2026 09:15:24 -0700
X-Gm-Features: AVVi8CcVnuVCx19L_GWSZ2nltEautD7sT8OALv94LzUOkIdPu2pxUDWRobjVJhw
Message-ID: <CAEvNRgGkjcVN80W7cNd1-tEUXAfnFXEekokh_VbMDb9XdecVVQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] KVM: selftest: Create KVM selftest runner
To: Sean Christopherson <seanjc@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, pbonzini@redhat.com, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, anup@brainfault.org, 
	atish.patra@linux.dev, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Jun 12, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> > On Thu, Jun 11, 2026, Ackerley Tng wrote:
>> >> Sean Christopherson <seanjc@google.com> writes:
>> >>
>> >> > On Wed, Jun 10, 2026, Ackerley Tng wrote:
>> >> >> Vipin Sharma <vipinsh@google.com> writes:
>> >> >> My (future) use case is that with hugepages, I want to run something
>> >> >> like
>> >> >>
>> >> >>   ./guest_memfd_test --order=0
>> >> >>   ./guest_memfd_test --order=9
>> >> >>   ./guest_memfd_test --order=18
>> >> >>
>> >> >> And 0, 9 and 18 are the supported HugeTLB orders on the machine being
>> >> >> tested. I'd like to iterate over supported HugeTLB orders at runner
>> >> >> runtime instead of at build time.
>> >> >
>> >> > No.  The right way to handle this is to define testcases for the "interesting"
>> >> > sizes, and then rely on the test itself to SKIP if the size is unsupported.  This
>> >> > is no different than a test that requires EPT, or nested VMX, or nested SVM, etc.
>> >>
>> >> That should work too. So at build time I'd make it define all the
>> >> possible HugeTLB sizes on every arch, and then skip as necessary.
>> >
>> > Not necessarily at "build time", the testcases can also come from your local
>> > environment.
>> >
>> >> Why though, why not find the supported sizes at runtime?
>> >
>> > You can find the supported sizes at runtime, just not in the test runner.  I want
>> > the runner itself to be largely oblivious to what's its running.  Disallowing
>> > more or less _any_ test specific configuration/setup in the runner is the only
>> > way I see of keeping the runner strictly focused on running tests/testcases.
>>
>> The runner should 100% focus on running tests, I think it's hard for the
>> runner to avoid the process of test discovery though.
>>
>> The current test discovery process is to go down the tree of directories
>> and find files, 1 file == 1 testcase. Each file should (statically)
>> contain a single command.
>>
>> Since you're not opposed to runtime discovery of test cases, how about
>> something like:
>>
>>     if the test case file has executable permissions
>>         execute it and get back a list of test cases to be run.
>
> I don't hate it, but I still dislike the idea.  I am all in favor of runtime
> *discovery* of testcases, but I am staunchly opposed to runtime *definition* of
> testcases.
>
> If I define guest_memfd testcases for 4KiB, 2MiB, and 1GiB pages, but the
> underlying system only support 4KiB and 2MiB, then I want to see a SKIP for the
> 1GiB testcase.  If the definition is dynamic, then the 1GiB testcase simply won't
> exist.
>

Seeing the SKIP is a huge advantage over dynamic definition. Thanks for
explaining. Makes a lot of sense now to have everything defined statically.

>>     else
>>         read it as a single test case.
>>
>> I'd then use the executable version, check HugeTLB setup on the machine
>> under test and return bunch of separate commands to be run (each with a
>> different HugeTLB size).
>>
>> The runner still doesn't need to deal test-specific config, that's part
>> of the executable that tells the runner what to run.
