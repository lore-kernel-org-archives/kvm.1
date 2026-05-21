Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18FC3E92B7
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373724; cv=none; b=ffCfXJCmXVscSdsOBBK8o6I/P20+QQjcenXAu516nY49QwWDpKLsKFaDPp0epnWn2i/mwzr3x0PTEs+o+nlhbps6hVwvD29Kce5vlqYpcGuQS5VOonndR7OOhFNzwz2aIBGSTsDpCvhVzXfNAvvfvD6D5JGYURjzRu+gLksNmTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373724; c=relaxed/simple;
	bh=EUTY7c/wQ6odBf0NG7I5Wy1BmLLq056ywAdcPvlK/DM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D6gN2CmqFWW7cxTDGAm1GT35rAmhNNymqJJyXOTIpKQ/mzeK9H75d6lprDKI9eaw3DfTRAlT5ycA3snhY3LOrY02kxlMO+gaCzd7f5BFB1j+jAO36NKTFohSzY/27e6/B6WwwaRAxBWn3PT7V36ax8x61YwhfanmYBULun91DLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhLF7GX2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhLF7GX2"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8292a9605aso3031611a12.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779373722; x=1779978522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qpfg2DB42qQ3bvRNWMtAmmCZ15+qKS/M5NjmIWYN8UU=;
        b=qhLF7GX2LRUGFLsi0h7rcnAUm/EFg9z2fHP25yRQh13W3UmjURiSukTgWqEyYjiKME
         AzRriDpW4HVud5cMYcLN79UA0nRz7ViAFB6NhVHQ5F4kx967w13tBVs2xxHFb8q8QXqO
         OLp/tZDRx5RCRZzwx1d/8NaY6IYgUZujrh5N/ODc752Rlssdz3GJC8N1goPELOpq54VK
         7QveePc/69fUYTr+R6YXyAVu8xYqcF7fXAm3X6MIbMewA6NFqYXZ2yHDhBR2hVrUSfft
         2rw+sIY5HFbhI4oYIVbrd9rmgFGFWDLkzWTMu1i+ZMjFy/UGZtPW9/FiKG9l+InVN6PM
         47Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373722; x=1779978522;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qpfg2DB42qQ3bvRNWMtAmmCZ15+qKS/M5NjmIWYN8UU=;
        b=l9eVd4hsgIcLIQCoAiNFV28kbSBP1kUyGLjnHE1IVOt6wejvXDFZHkbe9sCLRR9DFt
         ODymq/2uJQDAthDfeEAc437aauow5kqwOZPGpA6fD5f48TVHJabzMAeLYlo9CJzM6ZW1
         D13gPygrAPUA7ZwTJLLPD0bLXOF4rpH58/RzAVkaJnq4KcxLGrH6T93d1ACmrgUFnW1R
         JXu/C9DH+InSuJUK6hlpgADVOJB2+c35sHmUJ9F4crUsebRRtK8YcKIFc9eiuZEJq5eZ
         XW8+yDKswvfXjEEl7gnUup0cDObcNwn66BIokl6CFxcmnS4gIsd4nNHAy/o6hEjw7pLD
         HVCw==
X-Forwarded-Encrypted: i=1; AFNElJ9s3Ez3g1s7BGHZKy5trkuPOyqtGBT3Tdkw3EmEu0FMaWpSozlgoQ06h5r8nxrSTAGIh6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/2hPVQRBitKXFD0fBq9wtiH16pn+3zzi3Q3jZOPipXVe9VEst
	vJLPWLdIEpa/5IJBaBJYTVCDNd4tE5YRflstFpxVKGsEvX1CKS7JkmOoaTrfLQmY0GxDlN4BqR3
	Sr8R62Q==
X-Received: from pgly11.prod.google.com ([2002:a63:180b:0:b0:c82:cd84:79d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0a:b0:3a2:d79c:4149
 with SMTP id adf61e73a8af0-3b3087f5270mr3919162637.28.1779373721947; Thu, 21
 May 2026 07:28:41 -0700 (PDT)
Date: Thu, 21 May 2026 07:28:41 -0700
In-Reply-To: <202605210807.f147e0c4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501203537.2120074-3-seanjc@google.com> <202605210807.f147e0c4-lkp@intel.com>
Message-ID: <ag8WmcdDjxkpbzXi@google.com>
Subject: Re: [PATCH v2 2/6] KVM: selftests: Add a test to verify SEV {en,de}crypt
From: Sean Christopherson <seanjc@google.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026, kernel test robot wrote:
>=20
>=20
> Hello,
>=20
> kernel test robot noticed "kernel-selftests.kvm.make.fail" on:
>=20
> commit: f6ed3165a8ced57973a0919d0ead11eaff393477 ("[PATCH v2 2/6] KVM: se=
lftests: Add a test to verify SEV {en,de}crypt")

Ah, this is a local commit, from applying the patch.  I fixed up the semant=
ic
conflict when applying, i.e. I did NOT botch 6edd35e77a42 ("KVM: selftests:=
 Add a
test to verify SEV {en,de}crypt debug ioctls"). :-)

> url: https://github.com/intel-lab-lkp/linux/commits/Sean-Christopherson/K=
VM-SVM-Fix-page-overflow-in-sev_dbg_crypt-for-ENCRYPT-path/20260502-190513
> patch link: https://lore.kernel.org/all/20260501203537.2120074-3-seanjc@g=
oogle.com/
> patch subject: [PATCH v2 2/6] KVM: selftests: Add a test to verify SEV {e=
n,de}crypt
>=20
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-917719c412c4-1_20260508
> with following parameters:
>=20
> 	group: kvm
>=20
>=20
> config: x86_64-rhel-9.4-kselftests
> compiler: gcc-14
> test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 3=
2G memory
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202605210807.f147e0c4-lkp@intel.=
com
>=20
>=20
> gcc -D_GNU_SOURCE=3D -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests=
-f6ed3165a8ced57973a0919d0ead11eaff393477/tools/testing/selftests/../../../=
tools/testing/selftests  -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftes=
ts-f6ed3165a8ced57973a0919d0ead11eaff393477/tools/testing/selftests/cgroup/=
lib/include -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -=
Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT -U_FORTIFY_SO=
URCE -fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset -fno-built=
in-strnlen -fno-stack-protector -fno-PIE -fno-strict-aliasing -I/usr/src/pe=
rf_selftests-x86_64-rhel-9.4-kselftests-f6ed3165a8ced57973a0919d0ead11eaff3=
93477/tools/testing/selftests/../../../tools/include -I/usr/src/perf_selfte=
sts-x86_64-rhel-9.4-kselftests-f6ed3165a8ced57973a0919d0ead11eaff393477/too=
ls/testing/selftests/../../../tools/arch/x86/include -I/usr/src/perf_selfte=
sts-x86_64-rhel-9.4-kselftests-f6ed3165a8ced57973a0919d0ead11eaff393477/too=
ls/testing/selftests/../../../usr/include/ -Iinclude -I. -Iinclude/x86 -I .=
./rseq -I..  -isystem /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-f6=
ed3165a8ced57973a0919d0ead11eaff393477/usr/include -march=3Dx86-64-v2   -c =
dirty_log_perf_test.c -o /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests=
-f6ed3165a8ced57973a0919d0ead11eaff393477/tools/testing/selftests/kvm/dirty=
_log_perf_test.o
> x86/sev_dbg_test.c: In function =E2=80=98test_sev_dbg=E2=80=99:
> x86/sev_dbg_test.c:85:33: error: implicit declaration of function =E2=80=
=98vm_vaddr_alloc=E2=80=99 [-Wimplicit-function-declaration]
>    85 |         data =3D addr_gva2hva(vm, vm_vaddr_alloc(vm, BUFFER_SIZE,=
 KVM_UTIL_MIN_VADDR));
>       |                                 ^~~~~~~~~~~~~~
> At top level:
> cc1: note: unrecognized command-line option =E2=80=98-Wno-gnu-variable-si=
zed-type-not-at-end=E2=80=99 may have been intended to silence earlier diag=
nostics
> make[1]: *** [Makefile.kvm:329: /usr/src/perf_selftests-x86_64-rhel-9.4-k=
selftests-f6ed3165a8ced57973a0919d0ead11eaff393477/tools/testing/selftests/=
kvm/x86/sev_dbg_test.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kself=
tests-f6ed3165a8ced57973a0919d0ead11eaff393477/tools/testing/selftests/kvm'
> make: *** [Makefile:217: all] Error 2
>=20
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260521/202605210807.f147e0c4-lk=
p@intel.com
>=20
>=20
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>=20
