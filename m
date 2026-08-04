Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F2943CE55
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887525; cv=none; b=r5Qinz5QF/5nytBAWbLifavjsiOrt9QYEN8Z3M7DgKpOhxPJ9FwPuxrhyCTiD563YyYWK8ugqMZlwe1d+9cp9Fm7dZi+wRyO7h0xj8xBSGFetVFS1O1VnWl6V8hw4KHEu7qZDt9PL6QX4aVxvJpKTHTq/ujqytV97N8H3aIZrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887525; c=relaxed/simple;
	bh=/yVKj52l0/EVHXAja7jDcSfmti6GjgpZIxz4JWezye4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p4WA0Sn1TgbN08q8azXJIGUhHTgR6pLq1kuTb3HhK9e+YlDXyA9EKIsGCFyqzjS/XESckXDnQ9NYQgax62qm/J5BMcUqWWP33TYQG6r2tqWVmfBMXMVNJGy8IjYKjcjAXynTVLLturw72CyieIwOM3MSSbZyDb6EUKr13uqOI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wnk2KjrB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wnk2KjrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559041F00A3A;
	Tue,  4 Aug 2026 23:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887524;
	bh=OiXrxXppzFqPj4fRYhyRgWwip8Y0N4dto0VPiI8TnbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wnk2KjrBE3coWbIOAK7N27pXzggqp1hHXnwWrukYaaq1+JTW33PDpNY7vxBYtwmiA
	 XoLr6t/PlnF8xplewaKYaDTk/qK6/aacaT/qIpqQ745YzSUnZfgj4Q3+mP2QQqNDLA
	 CDRyfJ76u2zGXPgISg+j6YrvUPPkBWzFTDUPnsMolFmhJ1dP3z0pvGNkhWlQrHYEPx
	 CG21BkEGdjcFUW7BWMGehRzB2APcXtwHE+uyfF3duyIZ4jelHOmr2uDqj3raeU9BF9
	 SnYFbGZ53oagLli0AuDsA48LsQhgoCnJvBto7ucfM5tyrfhuFDEZ36ogX3IJOd7f2k
	 0+I9OJ2xfId7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/17] KVM: x86: Move "no master clock" fallback from
 __get_kvmclock() to get_kvmclock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804233923.3504629-8-seanjc@google.com>
References: <20260804233923.3504629-1-seanjc@google.com>
 <20260804233923.3504629-8-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 23:52:03 +0000
Message-Id: <20260804235204.559041F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The function `__get_kvmclock_master_clock()` is missing a `return =
true;` statement on its success path, causing it to return an undefined boo=
lean value.
--

--- Patch [7]: [PATCH v8 07/17] KVM: x86: Move "no master clock" fallback f=
rom __get_kvmclock() to get_kvmclock() ---
commit cb25993776f1881f5ff66de261984bd8992ceece
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Move "no master clock" fallback from __get_kvmclock() to get_kvmc=
lock()

This commit refactors the kvmclock retrieval logic by extracting the master
clock fallback out of the inner helper and changing it to return a boolean.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b520928579129..7366d4602f89f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -1667,8 +1673,6 @@ static void __get_kvmclock(struct kvm *kvm, struct =
kvm_clock_data *data)
>  				   &hv_clock.tsc_shift,
>  				   &hv_clock.tsc_to_system_mul);
>  		data->clock =3D __pvclock_read_cycles(&hv_clock, data->host_tsc);
> -	} else {
> -		data->clock =3D get_kvmclock_base_ns() + ka->kvmclock_offset;
>  	}
>  }

[Severity: High]
Does this function need to return true on the success path?

Since __get_kvmclock_master_clock() was changed to return a bool, it returns
false on the early exit paths, but appears to fall off the end of the
function without explicitly returning a value on success.

Since the return value here is undefined, could it evaluate to false in the
caller? If so, get_kvmclock() would incorrectly trigger the fallback logic:

get_kvmclock()
{
        if (!__get_kvmclock_master_clock(kvm, data))
                data->clock =3D get_kvmclock_base_ns() + ka->kvmclock_offse=
t;
}

This could overwrite the accurately calculated data->clock with the base
offset calculation, while leaving data->flags populated with master clock
flags.

> =20
> @@ -1678,8 +1682,11 @@ static void get_kvmclock(struct kvm *kvm, struct k=
vm_clock_data *data)
>  	unsigned seq;
> =20
>  	do {
> +		data->flags =3D 0;
> +
>  		seq =3D read_seqcount_begin(&ka->pvclock_sc);
> -		__get_kvmclock(kvm, data);
> +		if (!__get_kvmclock_master_clock(kvm, data))
> +			data->clock =3D get_kvmclock_base_ns() + ka->kvmclock_offset;
>  	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804233923.3504=
629-1-seanjc@google.com?part=3D7
