Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5DE3B8BDA
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478856; cv=none; b=ogkNi+NUMlo1tUlF5L1GlzLhM66RwxJDML3JAFvicuy3o2jwuhFia3guiSXLnHcCX3EtaIKqvBWPNhXbxeqQqY6/UqkMQxwIRFjVD76AQQ6ePSaJvtvR5ks8zEJ8/BInT9nA1VR/Zex09qoL/9fpnL+x+NsrFLs6N13w22LF+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478856; c=relaxed/simple;
	bh=qRDN0fnnW4RIfCr9ySb4XRCE0fAhBJXlZ7AaHfCZ+i4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZkUmkB+05MMajygFAmGUpgS1w+6sQrpjAGE14QEzYQdrxLnd7NFeSglIMiNj/TOqSExxurDkyCc/+uawg4rd6FFjmp6tCt+WWSFxqO31R8F0tZfIcDyUK3QlEwPfb08/V2XZzyDyt+Pvkia7IDfuhwj8wFnC0UUVZz54+H53yJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muQWiVDy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muQWiVDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285931F0089B;
	Tue, 15 Sep 2026 13:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789478854;
	bh=CZHZsKeYsul45RbpVJTRy+Fv03/aFg3qaGU1KJ6jwFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=muQWiVDyB4JB7dRXeWIImaXOti29oPBGsCBY+JXvN51W7dOFfGndzjbdyp1wYYVkW
	 3CmdZPIURbZ0EVuWmJA+ZVsTVoJznJO0P0c5IRWHAtpqEMpXfxyzpnbJZ31z3SDFWt
	 65Qr99dmjD+ei5uM9EyXNYyZQrqYutGUfMOczKCa5BzQte/rJGWkaI93KZ9h32Q0nc
	 1oNoOkEp8NsqD9yUE5drrsWkfICe4RjvZRvkrmeEOYEm6+bBFgj0gZCWAZpQ5BYGRs
	 D8f9wdq/H0HHw9HcLz0/NnRylAVxW+2fbAOuCaY1yyJ138bA7SHP5xymfHexHNEsnl
	 VGrN5BmVbh1Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] cpuidle: add per-CPU latency_limit_ns sysfs
 attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Harivel" <aharivel@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260915131310.1053834-2-aharivel@redhat.com>
References: <20260915131310.1053834-1-aharivel@redhat.com>
 <20260915131310.1053834-2-aharivel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 13:27:33 +0000
Message-Id: <20260915132734.285931F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] cpuidle: redundant sysfs UAPI bypasses PM QoS framework
- [Medium] cpuidle: TOCTOU data race in latency_limit_ns evaluation
- [Medium] cpuidle: deferred enforcement of latency_limit_ns due to missing=
 wakeup
--

commit 392083e97e8c2f4fec9d7c53da59689554ffca38
Author: Anthony Harivel <aharivel@redhat.com>
cpuidle: add per-CPU latency_limit_ns sysfs attribute

This commit introduces a new per-CPU sysfs attribute, latency_limit_ns, to
set an upper bound on exit latency for idle states. It modifies
cpuidle_governor_latency_req() to cap the latency constraint using this new
value.

> diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
> --- a/drivers/cpuidle/governor.c
> +++ b/drivers/cpuidle/governor.c
[ ... ]
> @@ -119,5 +121,11 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
>  	if (device_req > global_req)
>  		device_req =3D global_req;
> =20
> -	return (s64)device_req * NSEC_PER_USEC;
> +	result =3D (s64)device_req * NSEC_PER_USEC;
> +
> +	dev =3D per_cpu(cpuidle_devices, cpu);
> +	if (dev && dev->latency_limit_ns && dev->latency_limit_ns < result)
> +		result =3D dev->latency_limit_ns;

[Severity: Medium]
Is it possible that this introduces a duplicate per-CPU sysfs attribute for
capping exit latency?

The exact capability seems to already exist via the PM QoS framework
(/sys/devices/system/cpu/cpuN/power/pm_qos_resume_latency_us).

By creating an uncoordinated interface, could this bypass PM QoS tracking a=
nd
hide the constraint from other subsystems that query PM QoS?

[Severity: Medium]
Could this result in TOCTOU data races or torn reads since
dev->latency_limit_ns is evaluated locklessly three times without READ_ONCE=
()?

If a concurrent sysfs write increases the value between the bounds check and
the assignment, might it bypass the PM QoS limit constraint, allowing the C=
PU
to incorrectly enter a deeper idle state?

Also, on 32-bit architectures, could these unprotected 64-bit reads and wri=
tes
be torn?

> +
> +	return result;
>  }
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
[ ... ]
> @@ -207,8 +207,44 @@ static void cpuidle_sysfs_release(struct kobject *ko=
bj)
>  	complete(&kdev->kobj_unregister);
>  }
> =20
> +static ssize_t show_latency_limit_ns(struct cpuidle_device *dev, char *b=
uf)
> +{
> +	return sysfs_emit(buf, "%llu\n", dev->latency_limit_ns);
> +}
> +
> +static ssize_t store_latency_limit_ns(struct cpuidle_device *dev,
> +				       const char *buf, size_t count)
> +{
> +	u64 value;
> +	int err;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	err =3D kstrtou64(buf, 0, &value);
> +	if (err)
> +		return err;
> +
> +	dev->latency_limit_ns =3D value;
> +
> +	return count;

[Severity: Medium]
When this limit is updated, should we be sending an IPI or wakeup to the
target CPU?

If the CPU is currently in a deep idle state with an exit latency greater t=
han
the new limit, it might not exit the C-state until the next hardware interr=
upt.

This seems to defer the enforcement of the latency constraint, whereas PM Q=
oS
normally handles this by calling wake_up_all_idle_cpus().

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915131310.1053=
834-2-aharivel@redhat.com?part=3D1
