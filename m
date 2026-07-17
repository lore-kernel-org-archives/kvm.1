Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66669346AC2
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 03:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784257375; cv=none; b=ba5BC2EQSAy3zZ5pp8q4KXdhBah7PJiZxtZnhMi+pZOWvFs3yt2RSKbp+W2e+/4sKuCGCgx5onRD8+tPkoGQCU1jcJFw3bpquruPrxFVVZiKwx5bjs+w6xhooIKEjbkHKNeGJqeU8NWsHGaqmMRH3aqR59y+CJwmBJ1c2iiCI0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784257375; c=relaxed/simple;
	bh=LONeDMb+UMp3w8PpMR6ELRp7HOJmPzIptom95SWo0Ag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ICyZKDoGw8RNfoEx/Q7jkuKsS8IHk2fSu1EGjIKSJHwdOpImugjSXZJS3kDAy+n7Oa1NZenUehMUpBmNBkN3+vuoOPX+jl46o2se6RT214d5VhyFG0DRnm26G/jm8UkizyaXjK4ytbxZBjGZHFHnQeDCmVhS2Qo2WiRKrx0hBTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlE2l2QP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlE2l2QP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC92C1F000E9;
	Fri, 17 Jul 2026 03:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784257373;
	bh=3tsoV6pYdintvOFPBRnsl3/AAgm+hH6qqAaxCk3Oi4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XlE2l2QPywOj6EOmlYXD7qb1MTt7txeDP6QipVRuJl6RLPqATN37RKZOEu4jmgsFI
	 2rx7BOLVENDFZqnuR+lkYfQIhaIGl5F0Y9JVs8BKirnGZOOnOjAtvBu51G62+opcn3
	 3HbftnePTMf+3O3CMGAGWNRedHndfRVvlc1AY/0l7KOSDn7CClzF9ULugPnuuOBnl6
	 4MZaVWaVoWmdslnmvtNUkFoObEM6evOBIMsKLnl6ytG8RpLiter96OMvPz/jZ3zfZY
	 O2cVGYqSIWrt+xdpck84vwoCxRRx2PW2lT9jR3YM8lIXadMLyxv+lfdJojSE2YMhbH
	 WEqCw3pYKe77A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost: reject zero-size IOTLB INVALIDATE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weimin Xiong" <xiongwm2026@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716030236.124322-1-xiongwm2026@163.com>
References: <20260716030236.124322-1-xiongwm2026@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 03:02:53 +0000
Message-Id: <20260717030253.BC92C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch adds a zero-size IOTLB INVALIDATE check to the generic v=
host handler but completely misses the vDPA-specific handler, leaving vDPA =
endpoints vulnerable to the IOTLB wipe bug.
- [High] The patch prevents `msg->size =3D=3D 0` but fails to check for int=
eger overflow when `msg->size` is extremely large. This causes `last` to wr=
ap around, creating an inverted interval that incorrectly deletes unrelated=
 IOTLB entries.
--

--- Patch [1]: [PATCH] vhost: reject zero-size IOTLB INVALIDATE ---
commit a0b9048f6eadbd7dc5629192fc48fcb0eb48ce7f
Author: xiongweimin <xiongweimin@kylinos.cn>
vhost: reject zero-size IOTLB INVALIDATE

This commit adds a check to reject VHOST_IOTLB_INVALIDATE messages with a s=
ize
of 0 in vhost_process_iotlb_msg(). This prevents an underflow calculation
that would otherwise pass U64_MAX as the end of the range, incorrectly wipi=
ng
the entire IOTLB.

> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4c525b3e16ead..5d15fc41a3e98 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1657,6 +1657,10 @@ static int vhost_process_iotlb_msg(struct vhost_de=
v *dev, u32 asid,
>  			ret =3D -EFAULT;
>  			break;
>  		}
> +		if (!msg->size) {
> +			ret =3D -EINVAL;
> +			break;
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but does the vDPA-specific handl=
er
also need this zero-size check?

Looking at vhost_vdpa_process_iotlb_msg() in drivers/vhost/vdpa.c, it seems
to bypass this generic handler and processes the INVALIDATE message directl=
y:

drivers/vhost/vdpa.c:vhost_vdpa_process_iotlb_msg() {
    ...
	case VHOST_IOTLB_INVALIDATE:
		vhost_vdpa_unmap(v, iotlb, msg->iova, msg->size);
		break;
    ...
}

If a userspace application sends an INVALIDATE message with msg->size =3D=
=3D 0
and msg->iova =3D=3D 0, vhost_vdpa_unmap() computes the last boundary as
iova + size - 1, which underflows to U64_MAX and could delete the entire ma=
p.

A similar underflow might occur if an IOTLB UPDATE mapping fails in
vhost_vdpa_va_map(). It calls vhost_vdpa_unmap(v, iotlb, iova, map_iova - i=
ova)
which would pass a size of 0 if it fails on the first iteration.

Could this leave vDPA endpoints vulnerable to the same IOTLB wipe bug?

>  		vhost_vq_meta_reset(dev);
>  		vhost_iotlb_del_range(dev->iotlb, msg->iova,
>  				      msg->iova + msg->size - 1);

[Severity: High]
This is a pre-existing issue, but could this calculation overflow u64 and
create an inverted interval?

If a userspace application provides a large size (for example,
msg->iova =3D 0x1000 and msg->size =3D U64_MAX), msg->iova + msg->size - 1 =
will
overflow and wrap around to 0xFFE.

Unlike vhost_iotlb_add_range_ctx(), vhost_iotlb_del_range() in
drivers/vhost/iotlb.c doesn't seem to validate that start <=3D last before
querying the interval tree:

drivers/vhost/iotlb.c:vhost_iotlb_del_range() {
	struct vhost_iotlb_map *map;

	while ((map =3D vhost_iotlb_itree_iter_first(&iotlb->root,
						   start, last)))
		vhost_iotlb_map_free(iotlb, map);
}

The interval tree overlap check evaluates to true for any existing interval
that spans the inverted gap, which could cause valid, unrelated IOTLB entri=
es
to be incorrectly deleted.

Does this need an upper-bound overflow check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716030236.1243=
22-1-xiongwm2026@163.com?part=3D1
