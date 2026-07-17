Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B434A795
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784257387; cv=none; b=L40j59F63b6byrTwv/h9qXwh4kvuciihmGnowmUIhwfG7Omln681ocT5v7+TLbrytWkMnGFJPVoYccXVewjcUNUKF9jzarHy50P+v3gbkaBd6sMIPT9D+tXLyfJQDnc2qBUOqJqnTOMY3WbsZLJUFAD+Imt1fSpar/es0O3kuJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784257387; c=relaxed/simple;
	bh=KuA5tltNa499DF+tBZw7aVzb+sFhB18iupN0DBQeqr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CLncWgKz2iImdKXGbxzqawqGtOep4m3/ImnpKwHenL+jtnDEOnshPgnj5SNcMr/hJbiyVOrz7ItYMyyBqKB6APiszP2ECkannBIEpvsoOgGzoliXMZZUuhfHZyBD2NLgiy7dhNgue8CFdu5hQlfM7Dys4GWCfvnsGCI21RcTxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQYfA/K4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQYfA/K4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C511F00A3A;
	Fri, 17 Jul 2026 03:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784257386;
	bh=8WqfFtkuLIyzxyOwTZCjyLpdXW89h+E08DQT87ZbUI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VQYfA/K4wpAoTuaQN5x0rU61uT0XH49w1DIdCdeGSbMyWUSUXKXSbOn8S9dvyxJba
	 ASgfbqqlWkeaW45I2XfOu9eU8mzGXCScddlsIiRTpvstIhJ59AY/VLpowFeHrmEJLj
	 B6nOz6vyN3sRsunvjtejyAmy0SkTt0vPtFhjKBk4/b+iqVFitFkOpT/Cbp+wwVoa51
	 /Sn1QNxFkPZOvY9LgFsNl53cUsqCOgkJQlv44LVthXSSmO1mTVOW8h1+H11zwAZx6T
	 2KyG234fgZUvILQ8S8ZAW9c1dKd971xvbZdxAFcEeegkDdO5pYjj36ulp4pKCQWLUr
	 q/B7kOquiur9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost-vdpa: propagate set_map error to caller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weimin Xiong" <xiongwm2026@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716030242.124455-1-xiongwm2026@163.com>
References: <20260716030242.124455-1-xiongwm2026@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 03:03:05 +0000
Message-Id: <20260717030305.F1C511F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch introduces a critical DMA Use-After-Free (UAF) vulne=
rability by breaking the `v->in_batch` state machine.
--

--- Patch [1]: [PATCH] vhost-vdpa: propagate set_map error to caller ---
commit a21d695ba480576c165ed7bd7fa965169ba30248
Author: xiongweimin <xiongweimin@kylinos.cn>
vhost-vdpa: propagate set_map error to caller

This commit updates vhost_vdpa_process_iotlb_msg() to propagate the return
value of ops->set_map() during VHOST_IOTLB_BATCH_END operations. It modifies
the switch case to capture the error and break early.

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa0d0a..908ca383b1522 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1292,8 +1292,10 @@ static int vhost_vdpa_process_iotlb_msg(struct vho=
st_dev *dev, u32 asid,
>  		v->in_batch =3D true;
>  		break;
>  	case VHOST_IOTLB_BATCH_END:
> -		if (v->in_batch && ops->set_map)
> -			ops->set_map(vdpa, asid, iotlb);
> +		if (v->in_batch && ops->set_map) {
> +			r =3D ops->set_map(vdpa, asid, iotlb);
> +			break;
> +		}
>  		v->in_batch =3D false;
>  		break;

[Severity: Critical]
Does this early break bypass the reset of v->in_batch?

If VHOST_IOTLB_BATCH_END is processed and ops->set_map is present, the swit=
ch
statement exits before executing v->in_batch =3D false. This leaves v->in_b=
atch
permanently set to true.

Later, if a VHOST_IOTLB_INVALIDATE message is processed, vhost_vdpa_unmap()
checks the batch status:

drivers/vhost/vdpa.c:vhost_vdpa_unmap() {
    ...
    if (ops->set_map) {
        if (!v->in_batch)
            ops->set_map(vdpa, asid, iotlb);
    }
    ...
}

Since v->in_batch is still true, ops->set_map() is skipped. The software
unpins and frees the host pages, but the hardware IOMMU mappings are never
removed. Could this regression allow the hardware device to DMA into reused
host memory after it is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716030242.1244=
55-1-xiongwm2026@163.com?part=3D1
