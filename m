Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6A48096F
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329912; cv=none; b=jvWzQcUzB1rdY0SwBE/LbT/qdR7DV4vYz9+82wzuWefxns4aaEz0TA5W6umynjTZpLruHmCSYE24VaGWW3dXeQJnPnZp7qeKHLEMCTXrjJ2G5+Mgx7MrpfXHXGguhRAzvDivfMy3O/0k/b2NyYBMnexeDCbXiXIXUypwmkTbelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329912; c=relaxed/simple;
	bh=qlPI+Her7IXirv9KxJ+Jo3LYNN9ER6CBKD+tzs4LFLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=suVOxTUNDAEs0DQiPah8mMUDPDMsUQKWxyH4WLzwze33FYXbpMalj9uSGxrFuZ/rIrA26Q00Be5yO+VnwbLU/9uofSCS1XWYZKBmj7U0vu+vPME2fVtNJfBg/N3VvzoJzZ03HS4zuqnOPI2UaF/glDsYhClnn/PgupyvANW3/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpR+7e+E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpR+7e+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EA71F00A3E;
	Wed, 29 Jul 2026 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785329909;
	bh=DH51hATjIkFIPEQT5r6AD8XJ3InqIajnInm8qrjGPvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GpR+7e+EE+nICmXswal4QhKxDLAjTXHJTRIYXGDpFpAhWTdmFWH3pdnt4/nhycfwW
	 K279+PlNvxwY+TwAxyAzVyXstZovQd6QN7yQ3yzEU1Mv0AYFQGGuz+UpDMsTue3omM
	 pIXZpyH6GYhrV4rSCftNMHuap5D9wYUP1xjoREbZete/SXCcp9umbncxE1Qw8la9fv
	 t1jsdoaPzxqhEMI62ZLSq2mos+9P8kPK1qDkAH81j89W8ylZdLX29BNYLxJOTlxwyi
	 ODCkHQ8tekET4ZOJvp7iyaq8qQnC/8jqIb1e6dxZMbzPeoJhWSKOWSwRqG1KiFG6Nf
	 qcnY3MFQ84Whw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the
 Quote buffer size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Fang" <peter.fang@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729122939.1340412-4-peter.fang@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-4-peter.fang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 12:58:28 +0000
Message-Id: <20260729125829.52EA71F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `wait_for_quote_completion` timeout logic is inverted due to an of=
f-by-one error in the loop condition.
--

--- Patch [3]: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the =
Quote buffer size ---
commit 0a36558aa4f35238ff748cfc6efbe53e1e0e02ea
Author: Peter Fang <peter.fang@intel.com>

virt: tdx-guest: Use a variable to store the Quote buffer size

This commit replaces the fixed GET_QUOTE_BUF_SIZE constant with a dynamic=20
variable to prepare for future dynamic Quote buffer sizes. All users of=20
the buffer size have been updated to read from this new variable.

> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/=
tdx-guest/tdx-guest.c
> index f47c5429d002e..3d3f79ab45af0 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
[ ... ]
> @@ -285,7 +284,7 @@ static int tdx_report_new_locked(struct tsm_report *r=
eport, void *data)
>  	if (desc->inblob_len !=3D TDX_REPORTDATA_LEN)
>  		return -EINVAL;
> =20
> -	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
> +	memset(quote_data, 0, quote_data_len);
> =20
>  	/* Update Quote buffer header */
>  	quote_buf->version =3D GET_QUOTE_CMD_VER;
> @@ -296,7 +295,7 @@ static int tdx_report_new_locked(struct tsm_report *r=
eport, void *data)
>  	if (ret)
>  		return ret;
> =20
> -	err =3D tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
> +	err =3D tdx_hcall_get_quote(quote_data, quote_data_len);
>  	if (err) {
>  		pr_err("GetQuote hypercall failed, status:%llx\n", err);
>  		return -EIO;
>  	}

[Severity: High]
This is a pre-existing issue, but while reviewing this code I noticed a=20
logic flaw in wait_for_quote_completion() which is called immediately after=
=20
this hypercall.

drivers/virt/coco/tdx-guest/tdx-guest.c:wait_for_quote_completion() {
    ...
    while (quote_buf->status =3D=3D GET_QUOTE_IN_FLIGHT && i++ < timeout) {
        if (msleep_interruptible(MSEC_PER_SEC))
            return -EINTR;
    }

    return (i =3D=3D timeout) ? -ETIMEDOUT : 0;
}

Does this timeout condition return the correct value?

Due to the post-increment in i++ < timeout, if the loop actually times out,
i becomes timeout + 1. This causes i =3D=3D timeout to evaluate to false and
incorrectly return 0 (success).

Conversely, if the quote succeeds exactly on the last iteration,
short-circuiting leaves i =3D=3D timeout true, which would incorrectly retu=
rn
-ETIMEDOUT and cause a valid quote to be rejected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729122939.1340=
412-1-peter.fang@intel.com?part=3D3
