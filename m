Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55551471264
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633215; cv=none; b=nmxLqe/2hHXdppNTj2Qxzn8dpoMM20Jjqg3SmZGCIbaZYdqe7U2JEyLpAIW7rSSx43IGZFcr3HvCWonQlbeHarGvNzUvXD6uu2DfbZ0+ZdS2cVr5lAYKcCIyJXiyHIIq9FEecgmNkF04Z4EbKKl5bFQhYfaABx3lesRglGEa2U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633215; c=relaxed/simple;
	bh=5sM+1zSlul2kfYvbLYRPOSLBGN5aFbmaQpNogzsyE7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KfCdeZAssqoSfK+JTaO/Idqn63elqg0W0lvVYtloBURYIpY6dGiOiG9tXdEjqqw7wxvFI3zHdh74sOfWv4fPyBomE+Uo/gxcQCz1/vmc9AKAQtdjKMbPA7H8s5YZzcJn9L05vGAiZe0yyVFugzTo0rJLYuxmVyOmdQduHTTqsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBM/XjH1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBM/XjH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA4D1F00A3E;
	Thu, 13 Aug 2026 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633209;
	bh=yaVUpc1VxFtIh5R5GXu1iwxwShjuXGAgPOGgUALwEqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PBM/XjH1JT6cOwPh5zbA/1iHBl1WIfqU1z7oRm1rFYY18GGPu+ZwqqGBDXwzdCUyr
	 YXFalH1wd/4yMBU5tCUw4CSg+qpjmp4xnbXpL/VzVqFgbMUC6nxowIf0DSXxpgr414
	 clPdPM2xAXl3cB/cpW5Jl/3PQMwYUcU7EzcEpXEgAC6/lJ37tYpTb5sDaMN2Ooe3OX
	 97465gYjQMRNUfWzVRgdiRtdcu7JsY6IpHsJ2+3f3NV5MWoVGwvO0OXkJSYnBbUGNc
	 G9FiEXKyXR9bQ+a17/PISNiV16hAYXjL7YoEQQyFOrKwXVkiDBFqGj1/GlNs0iwTD+
	 m/0h8ve2GGuFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/10] vfio: selftests: Add mlx5 driver - data path
 and memcpy ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <9-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
References: <9-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:00:08 +0000
Message-Id: <20260813150008.ECA4D1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Race condition in CQ polling where the `recv_counter` doorbell is =
updated before all CQE fields are read.
- [Medium] Strict aliasing violation when extracting the 64-bit doorbell va=
lue via type punning.
--

--- Patch [9]: [PATCH v4 09/10] vfio: selftests: Add mlx5 driver - data pat=
h and memcpy ops ---
commit 22f15a19e89d217e93d4e9e51e36db1a9fa3c2c2
Author: Jason Gunthorpe <jgg@ziepe.ca>

vfio: selftests: Add mlx5 driver - data path and memcpy ops

This commit completes the mlx5 driver by adding CQ/QP creation, QP state
transitions, WQE posting, CQ polling, and the memcpy_start/memcpy_wait
callbacks. It enables functional DMA tests by implementing RDMA Write
self-loopback via an RC QP with force-loopback.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c b/tools=
/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
> index 804801cc564e7..e5e75adb25316 100644
> --- a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c

[ ... ]

> @@ -1343,6 +1343,354 @@ static void mlx5st_destroy_mkey(struct mlx5st_dev=
ice *dev)

[ ... ]

> +static void mlx5st_post_rdma_write(struct mlx5st_device *dev, u64 src_ad=
dr,
> +				    u32 src_lkey, u64 dst_addr, u32 dst_rkey,
> +				    u32 length, bool signaled)
> +{

[ ... ]

> +	/* Ensure WQE is visible to device before doorbell record */
> +	dma_wmb();
> +
> +	WRITE_ONCE(dev->qp_dbrec.send_counter,
> +		   cpu_to_be32(dev->sq_pi & 0xffff));
> +
> +	/*
> +	 * Ring doorbell: write first 8 bytes of ctrl to UAR BF register,
> +	 * iowrite has an internal dma_wmb() so the doorbell record will be
> +	 * visible.
> +	 */
> +	iowrite64be(be64_to_cpu(*(__be64 *)wqe),
> +		    (u8 __iomem *)dev->uar_base + dev->uar_bf_offset);

[Severity: Medium]
Does casting the struct mlx5st_send_wqe pointer to a __be64 pointer violate
strict aliasing rules?

Because files under tools/ assume standard -fstrict-aliasing, type punning
with incompatible pointers can cause the compiler to reorder the memory read
before the WQE fields are fully initialized, potentially sending uninitiali=
zed
data to the device doorbell.

> +	dev->uar_bf_offset ^=3D MLX5_BF_SIZE;
> +}
> +
> +/*
> + * Poll CQ
> + */
> +static int mlx5st_poll_cq_batch(struct mlx5st_device *dev,
> +				unsigned int max_cqe)
> +{

[ ... ]

> +		opcode =3D MLX5_GET(cqe64, cqe, opcode);
> +
> +		dev->cq_ci++;
> +		WRITE_ONCE(dev->cq_dbrec.recv_counter,
> +			   cpu_to_be32(dev->cq_ci & 0xffffff));
> +
> +		if (opcode =3D=3D MLX5_CQE_REQ) {
> +			dev->sq_ci =3D
> +				(u16)(MLX5_GET(cqe64, cqe, wqe_counter) + 1);

[Severity: High]
Can the hardware overwrite the CQE memory slot while the CPU is still parsi=
ng
it?

By updating the recv_counter doorbell record here, it signals to the hardwa=
re
that the CQ slot is free to be reused. Immediately after, the CPU reads the
wqe_counter (and syndrome on error paths) from the CQE. If the hardware pos=
ts
new completions rapidly, it might DMA the next CQE into the same slot before
these reads complete.

Could the doorbell update be delayed until after all fields have been read
from the CQE, or batched at the end of the poll loop?

> +			polled++;
> +			continue;
> +		}
> +		if (opcode =3D=3D MLX5_CQE_REQ_ERR ||
> +		    opcode =3D=3D MLX5_CQE_RESP_ERR) {
> +			dev_dbg(dev->device,
> +				"CQE error: opcode=3D0x%x syndrome=3D0x%x vendor=3D0x%x\n",
> +				opcode,
> +				MLX5_GET(cqe64, cqe, error_syndrome.syndrome),
> +				MLX5_GET(cqe64, cqe,
> +					 error_syndrome.vendor_error_syndrome));
> +			return -1;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0-v4-021df3fb5a3f+9=
8e-mlx5st_jgg@nvidia.com?part=3D9
