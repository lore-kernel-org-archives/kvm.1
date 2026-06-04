Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8F245020
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606153; cv=none; b=EyZ4IctmW+V2MYJsedkosOLwnw7cdqe7ZH93kDmFcNudJlfY+G8Rep9mE3pi4nU0b5694cZDisf9MSyRGsyZ96Fw8pdrl56IXKwF8jv4/QLSuLWN62kmudmHvQTO5IT1A8hcZKU2FBiNMiHtdmvBt/pWeIhXpYeyw99CGDXmwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606153; c=relaxed/simple;
	bh=YJkDE8NmJwLCfIe9P2SRzMUtdMjBbSiOWSVCfcrCUpE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f+kEf0l/ZY78lDQfg9vI//tVIOCdbdmjPA5NWyf0IWg1NRbXcQ1nOh9l9Pm+pN8VF/O2yAvf00VtjG4HeQhjfC3Hf3yB1BvxI6smQvQxPWx5tJlIzV++xu7XIPQCzzd21EMc5uVeksKeFAasif6hpnfswnflbm3e5AO0ej9GPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FftkLAPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FftkLAPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D601F00893;
	Thu,  4 Jun 2026 20:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780606151;
	bh=zSQvdChUiNh523jK06IupE/FmY66cAJmBCf4FiXfqq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FftkLAPx/mSJC9K7aSH7kl1TWzkkDLt8wzOdDUMK6EO37rj3mW/ApEzxUjT5SlX8b
	 CGDK0zxapJeCjglt7poUmgnrg1F4sZMtpFzOsyoRfNfbz4cBkyuqGCCXKkZ7kp9RhQ
	 WSn6cxe/p7xCTcL0ZqfzPcuyR01BuL1LZ1bBhU9lNTuCkjdThpYTOg1Pmz6sKuKqq/
	 KWklRt/4gNP1PLRB2KjoWJKMk4oeqwlDXwT9WdsvRnXCmJHMuMRekbGRKTvRhuY1lY
	 uPytk1HLwv7fVu3WO8X3rV5ipn8aN9VURV0M9UxIV9oqx0KOv6ryi0FyK+Ru+Hpx0E
	 a9w14Aksx0Fvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] KVM: selftests: Trigger save+restore randomly
 in the #PF stress test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604203546.365658-9-yosry@kernel.org>
References: <20260604203546.365658-9-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:49:11 +0000
Message-Id: <20260604204911.80D601F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Aggressive 100us signal interval causes test livelock and spurio=
us failures on slower hosts.
--

commit bf3ad650cf1e2ff2e1e4bd996b52e985a3657486
Author: Yosry Ahmed <yosry@kernel.org>

KVM: selftests: Trigger save+restore randomly in the #PF stress test

This commit updates the #PF stress test to trigger exits and save/restore
operations randomly via a background thread sending SIGUSR1. This replaces
the explicit GUEST_SYNC() calls to better exercise race conditions during
guest execution.

> diff --git a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.=
c b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> index 622d102179e66..92efb7ac9d95f 100644
> --- a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> +++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c

[ ... ]

> @@ -94,15 +96,41 @@ static void guest_access_memory(void *arg)

[ ... ]

> +static void *sigusr_thread_fn(void *arg)
> +{
> +	pthread_t vcpu_thread =3D (pthread_t)arg;
> =20
> -		GUEST_SYNC(guest_faults);
> +	for (;;) {
> +		pthread_testcancel();
> +		pthread_kill(vcpu_thread, SIGUSR1);
> +		usleep(100);

[Severity: Medium]
Could this aggressive 100-microsecond signal interval cause a livelock on
slower hosts or nested environments?

If the KVM VM-entry and EPT/NPT setup takes longer than 100 microseconds,
the pending signal might cause KVM to abort the entry and return -EINTR to
userspace before the guest makes any forward progress.

Because the main loop fully destroys and recreates the VM on every iteration
(via kvm_vm_release() and vm_recreate_with_one_vcpu()), the MMU state is
dropped, meaning the next loop starts completely cold. If every entry takes
longer than 100us, the test will repeatedly fail to enter the guest.

>  	}
> +	return NULL;
> +}

[ ... ]

> @@ -175,8 +215,11 @@ int main(int argc, char *argv[])
>  	}
> =20
>  	sync_global_from_guest(vm, guest_faults);
> +	TEST_ASSERT(guest_faults > 0, "No guest page faults triggered");

[Severity: Medium]
If the VM is livelocked as described above, will this assertion spuriously
fail because the guest never executed an instruction?

>  	pr_info("Guest page faults: %lu\n", guest_faults);
> =20
> +	pthread_cancel(sigusr_thread);
> +	pthread_join(sigusr_thread, NULL);
>  	kvm_vm_free(vm);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604203546.3656=
58-1-yosry@kernel.org?part=3D8
