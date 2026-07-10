Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C0A322B7B
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722283; cv=none; b=Eg1I8INYV24NzReh/+UjkiWEuPssfvgO8RvzoRhUuimZPXqi7RKn77aXmk7HTet5nd5WvsjcyjWfwHrz4cFzSanTdXcgTMSAew8bQMC+CyNAf5Zkkv/wwoUrN34Nlg3+lT10+vQmKQKOt8qNUZcFIBCzeb88vPNtz0JN55Z9hI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722283; c=relaxed/simple;
	bh=+lLZWtWzbq4zpfFekUKWgvj92iC3qcyKYYgwevyaIfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KhNkozf8/ljPPxg43GtxMyggBdcKvvV4/HwuLwFuaxx8Tv6FSij8kTrF6VYNQDuwgRdWxY4XmEHvxDwPYp/tOzFhm28kIEhE0jf4tTUzooPNEwdvFTISMr+tI2HKSGZ9gpVd+GMxYhdQXxc2rbiZWitQixbes6ZYzYY6E2IGJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKrBEBVM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKrBEBVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84191F000E9;
	Fri, 10 Jul 2026 22:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783722281;
	bh=zvE7s2XIMDATivfUv6Ks3GtUTRaGcG2A83utOid9S34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WKrBEBVMbYa2XS0AP8wbSdGJfp3EgdYxzevHRfHnyhq4U/Wd0QGC9KMhoX+gbq3Ct
	 3zh6AREHJ2JLcSwlHgQeqgbvpvpMuwv/HXTYtO+eseljxxfrOV6Ael+en/SgauJn5e
	 LISn2Kr0J/dNu+PEOBNzQ/j2/3LsNNK/xv4vq1K0HR7AXIiv4Fdi/pbwt8wz008Wbh
	 IE0pUu+17h2F5QzqKCRTAq3ifLuD0uUFNknlMBFr+o2z5kDvidfmaTmp5uQqclgWxK
	 wX8ZdeMv1fzGcB+fvu0ekXkQ+rCAx5SKu+YYJ4JRmrz4kO9QgIwPzvNeZOpbGFpubb
	 stPyyI+EcGCQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] vfio: selftests: igb: Extend memcpy completion
 timeout for line-rate hardware
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260710-igb_v3_b4-v4-5-56e7e2576cc1@google.com>
References: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
 <20260710-igb_v3_b4-v4-5-56e7e2576cc1@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:24:41 +0000
Message-Id: <20260710222441.A84191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest driver permanently desynchronizes its RX ring from =
the hardware upon encountering a dropped TX packet, leading to cascading te=
st failures.
--

--- Patch [5]: [PATCH v4 5/9] vfio: selftests: igb: Extend memcpy completio=
n timeout for line-rate hardware ---
commit 5b4ec7eb56b488ee6f3c3a7fb697c298ba1953f4
Author: Alex Williamson <alex.williamson@nvidia.com>

vfio: selftests: igb: Extend memcpy completion timeout for line-rate hardwa=
re
   =20
This commit increases the timeout in the igb driver selftest to wait for RX
descriptor writeback. It adjusts the wait time from 1 ms to up to 200 ms to
account for line-rate processing on real 82576 hardware. This provides enou=
gh
headroom for legitimate transfers to complete while keeping invalid-DMA tes=
ts
bounded.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> index cd51a72b0e7fa..172c95cea3c8a 100644
> --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> @@ -428,12 +428,23 @@ static int igb_memcpy_wait(struct vfio_pci_device *=
device)
>  	prev_tail =3D (igb->rx_tail + RING_SIZE - 1) % RING_SIZE;
>  	rx =3D &igb->rx_ring[prev_tail];
> =20
> -	retries =3D 100;
> +	/*
> +	 * Real 82576 hardware processes the descriptor ring at line rate.
> +	 * max_memcpy_size =3D (RING_SIZE - 1) * IGB_MAX_CHUNK_SIZE ~=3D 4 MB,
> +	 * split into 4095 1 KB frames.  At 1 Gb/s (~125 MB/s) the worst
> +	 * valid memcpy takes ~32 ms on the wire, plus per-frame preamble,
> +	 * SFD, IFG and FCS overhead (~3%) and descriptor fetch/writeback
> +	 * latency.  Wait up to ~200 ms before declaring the device hung;
> +	 * ~6x the line-rate floor leaves comfortable headroom for host
> +	 * scheduling jitter while keeping the intentional invalid-DMA
> +	 * tests bounded.
> +	 */
> +	retries =3D 200;
>  	while (retries-- > 0) {
>  		status =3D le32_to_cpu(READ_ONCE(rx->wb.status_error));
>  		if (status & 1)
>  			break;
> -		usleep(10);
> +		usleep(1000);
>  	}
> =20
>  	if (status & 1)

[Severity: Medium]
When the intentional invalid-DMA tests timeout, does the software RX ring
become permanently desynchronized from the hardware?

In igb_memcpy_start(), the software rx_tail is unconditionally advanced:

tools/testing/selftests/vfio/lib/drivers/igb/igb.c:igb_memcpy_start() {
    ...
		igb->tx_tail =3D (igb->tx_tail + 1) % RING_SIZE;
		igb->rx_tail =3D (igb->rx_tail + 1) % RING_SIZE;
    ...
}

During an intentional invalid DMA (like in the mix_and_match test), the IOM=
MU
blocks the TX fetch and the packet is dropped, so the hardware RX ring never
advances.

When igb_memcpy_wait() times out, it returns -ETIMEDOUT but leaves the
software rx_tail out of sync with the hardware RDH.

Could this cause all subsequent valid test loopbacks to fail because they
wait on the wrong descriptor slot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-igb_v3_b4-=
v4-0-56e7e2576cc1@google.com?part=3D5
