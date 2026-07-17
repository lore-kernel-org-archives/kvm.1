Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA132F7EED
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307843; cv=none; b=htWqoPGxXyfY+i1AELsx3kKuYC0CUIY6XrNPK44l34jl4tfvxuMkssRry+YRKkZMCkUsdHywHhdRQBZkk3ab+ThcQOFXPy7Y7jv8TVRAeFGAMKPF4XuTpHrRNAv4zghlBYtarTltEAZoYtoTLG61MPWjdD2kyfPQqUQc5Gretas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307843; c=relaxed/simple;
	bh=/NDpFYAO5ySRx7IrVGyt2GwcVfdjd6fwTFiRsvisUsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X24tnfwtd0RnLAmuhywzLXVbvsWr6g1cKj0O/WruNN+VXFHo6TgZhOxiSmCO4SyQtG7UUsOI2u6G0m8WWcWEXW309awbWrLOQp7sVIEkKb9SICRclp8uHzswp7nodoeveLFSV1vNBUubZVKBTA7ut6BWk011deFk1fyftO+xMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvByTogj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvByTogj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B637B1F00A3A;
	Fri, 17 Jul 2026 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784307841;
	bh=rSKwurb6dJMlAkENuqB/t67VjYQ62q9MlGD9uunrFjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XvByTogjNc+TJ/+ZmdoQag2exzzJkEBdUyVuqxC+RQ8vyATIasGo9dfN6nDZC5C7Z
	 7RaEYQ9tJ3G+8zSgZcWZKuJjf2K4wZ6ALvUpRrj0PVEJ7sCUZr/p5KZ2fnCXFL3lrA
	 UmuWmhDBpvk/vz9il7K6AJVHwgPrpfRrThra634oIgNrysJ4pAygO7EBkylM3YmNMC
	 gQ3QKrctVYhJAjzVBJavrmpJ+Ockt02N9WWs4iPGdLp74eu2JJCm39xdc5flmHt1ZQ
	 Bb4/71yf+0bAp+fcs/XIxR+o2S2vVB6UvJNg6VLmkODRfo6OEcRFSyKbhQVZQHPJDD
	 eifESoJPCa62w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/11] vfio: selftests: Add mlx5 driver - HW init and
 command interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <9-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
References: <9-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:04:01 +0000
Message-Id: <20260717170401.B637B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Medium] Valid hardware IDs like 0 are incorrectly treated as unallocated=
 resources, leading to resource leaks during teardown.
- [Medium] Stale command data read due to missing ownership bit poll in asy=
nc command completion.
- [Medium] Asynchronous MANAGE_PAGES reclaim loses track of remaining pages=
 if firmware claims fewer pages than requested.
- [Medium] Heap buffer overflow when processing unvalidated `num_claimed` c=
ount from firmware.
- [Medium] Out-of-bounds MMIO pointer derivation using unvalidated `uar_pag=
e` index.
- [Medium] Undefined behavior due to bitwise shift exceeding integer width.
- [Medium] Spurious failure during HCA teardown when the firmware temporari=
ly returns 0 reclaimed pages.
- [Medium] Unconditional RoCE capability query crashes the selftest on devi=
ces where RoCE is disabled or unsupported.
--

--- Patch [9]: [PATCH v3 09/11] vfio: selftests: Add mlx5 driver - HW init =
and command interface ---
commit c0063c1d972772b9afac6911db9fe5ce5e21c852
Author: Jason Gunthorpe <jgg@nvidia.com>

vfio: selftests: Add mlx5 driver - HW init and command interface

This commit adds an mlx5 ConnectX selftest driver that initializes hardware
VFs and PFs through the bare-metal command interface. It registers with the
VFIO selftest framework and handles base HCA boot sequences, EQ creation,
and resource allocation.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c b/tools=
/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
[ ... ]
> +	/* Read command queue geometry from BAR */
> +	log_sz =3D MLX5_GET_MMIO(initial_seg, seg, log_cmdq_size);
> +	dev->cmd_log_stride =3D MLX5_GET_MMIO(initial_seg, seg, log_cmdq_stride=
);
> +	dev->pages_slot =3D (1 << log_sz) - 1;
> +
> +	VFIO_ASSERT_LE((unsigned int)(1 << log_sz), 32u);

[Severity: Medium]
Does this bitwise shift trigger undefined behavior if log_sz is 31 or
greater? The shift 1 << log_sz uses a 32-bit signed integer literal,
and it evaluates before the bounds check in VFIO_ASSERT_LE is reached.

[ ... ]
> +	} else if (dev->pages_pending_reclaim) {
> +		batch =3D dev->pages_pending_reclaim < MAX_FW_PAGES_PER_CMD ?
> +				dev->pages_pending_reclaim :
> +				MAX_FW_PAGES_PER_CMD;
> +		dev->pages_pending_reclaim -=3D batch;
> +		mlx5st_pages_slot_reclaim(dev, dev->pages_pending_func_id,
> +					  batch);
> +	}

[Severity: Medium]
Does this lose track of the remaining pages if the firmware claims fewer
pages than requested?

In mlx5st_pages_slot_kick, the full batch is deducted from
dev->pages_pending_reclaim before the command executes. If the completion
handler receives a num_claimed less than the batch size, the un-reclaimed
difference does not seem to be added back.

[ ... ]
> +static void mlx5st_pages_slot_complete(struct mlx5st_device *dev)
> +{
> +	struct mlx5st_cmd_queue_entry *cmd =3D dev->pages_cmd_lay;
> +	void *cout;
> +
> +	dma_rmb();
> +
> +	cout =3D MLX5_ADDR_OF(cmd_queue_entry, cmd, command_output_inline_data);

[Severity: Medium]
Can this result in reading stale command data?

The output data is being read here without first polling the ownership bit
of the command entry. Does the EQE delivery guarantee that the DMA write of
the output data is fully visible to the CPU, or do we still need to check
MLX5_GET_ONCE(cmd_queue_entry, cmd, ownership)?

[ ... ]
> +		num_claimed =3D
> +			MLX5_GET(manage_pages_out, out, output_num_entries);
> +		for (i =3D 0; i < num_claimed; i++)
> +			iovas[i] =3D MLX5_ARRAY_GET64(manage_pages_out, out, pas,
> +						    i);

[Severity: Medium]
Could this cause a heap buffer overflow?

If the firmware returns a num_claimed value larger than the allocated batch
size of the iovas array, this loop will write out of bounds. Should we
validate num_claimed against the requested batch size before iterating?

[ ... ]
> +static void mlx5st_alloc_uar(struct mlx5st_device *dev)
> +{
> +	u32 out[MLX5_ST_SZ_DW(alloc_uar_out)] =3D {};
> +	u32 in[MLX5_ST_SZ_DW(alloc_uar_in)] =3D {};
> +
> +	MLX5_SET(alloc_uar_in, in, opcode, MLX5_CMD_OP_ALLOC_UAR);
> +	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
> +
> +	dev->uar_page =3D MLX5_GET(alloc_uar_out, out, uar);
> +	dev->uar_base =3D (u8 __iomem*)dev->bar0 + dev->uar_page * MLX5_HW_PAGE=
_SIZE;

[Severity: Medium]
Can this calculation result in an out-of-bounds pointer?

If the firmware returns an unexpectedly large uar index, dev->uar_base
could point outside the boundaries of the PCI BAR, which might cause a
segmentation fault when a doorbell is later written.

[ ... ]
> +static void mlx5st_fw_pages_reclaim(struct mlx5st_device *dev, u16 func_=
id)
> +{
[ ... ]
> +		mlx5st_cmd_exec(dev, in, inlen, out, outlen);
> +
> +		num_claimed =3D
> +			MLX5_GET(manage_pages_out, out, output_num_entries);
> +		for (i =3D 0; i < num_claimed; i++)
> +			iovas[i] =3D MLX5_ARRAY_GET64(manage_pages_out, out, pas,
> +						    i);

[Severity: Medium]
As mentioned in mlx5st_pages_slot_complete, could this also cause a heap
buffer overflow if the hardware returns a num_claimed larger than the batch
size of the iovas array?

> +
> +		mlx5st_fw_pages_free(dev, num_claimed, iovas);
> +		total_claimed +=3D num_claimed;
> +		npages -=3D num_claimed;
> +
> +		free(iovas);
> +		free(in);
> +		free(out);
> +
> +		if (!num_claimed && !dev->fw_pages_given)
> +			break;
> +		if (!num_claimed)
> +			VFIO_FAIL("MANAGE_PAGES RECLAIM: FW returned 0 but %d pages still giv=
en",
> +				  dev->fw_pages_given);

[Severity: Medium]
Will this abort the selftest sporadically?

The hardware can temporarily return 0 reclaimed pages while flushing intern=
al
states before making the pages available. Should this implement a sleep-ret=
ry
loop instead of immediately asserting failure?

[ ... ]
> +static void mlx5st_hca_teardown(struct mlx5st_device *dev)
> +{
[ ... ]
> +	dev->have_eq =3D false;
> +
> +	if (dev->eqn) {
> +		mlx5st_destroy_eq(dev);
> +		dev->eqn =3D 0;
> +	}

[Severity: Medium]
Could this skip teardown if the hardware allocates an EQ with an ID of 0?

Since 0 can be a valid hardware allocation ID, checking if (dev->eqn)
might skip destruction and leak the resource. Would it be better to check
dev->have_eq here?

[ ... ]
> +static void mlx5st_query_fl_caps(struct mlx5st_device *dev)
> +{
> +	u32 out[MLX5_ST_SZ_DW(query_hca_cap_out)] =3D {};
> +	u32 in[MLX5_ST_SZ_DW(query_hca_cap_in)] =3D {};
> +	bool fl_roce_en, fl_roce_dis;
> +
> +	/* Query RoCE capabilities */
> +	MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
> +	MLX5_SET(query_hca_cap_in, in, op_mod,
> +		 MLX5_SET_HCA_CAP_OP_MOD_ROCE | HCA_CAP_OPMOD_GET_CUR);
> +
> +	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));

[Severity: Medium]
Could this crash the selftest on devices that lack RoCE support?

Issuing a QUERY_HCA_CAP for the RoCE capability page blindly might
result in a BAD_PARAM failure from firmware if RoCE is disabled. Should we
check the roce support bit in GENERAL_DEVICE capabilities first?

[ ... ]
> +static void mlx5st_remove(struct vfio_pci_device *device)
> +{
> +	struct mlx5st_device *dev =3D to_mlx5st(device);
> +
> +	dev_dbg(device, "teardown: destroy_mkey\n");
> +	if (dev->mkey_index) {
> +		mlx5st_destroy_mkey(dev);
> +		dev->mkey_index =3D 0;
> +	}
> +
> +	dev_dbg(device, "teardown: dealloc_pd\n");
> +	if (dev->pdn) {
> +		mlx5st_dealloc_pd(dev);
> +		dev->pdn =3D 0;
> +	}

[Severity: Medium]
Similar to the EQ ID above, could this leak the Protection Domain if the
hardware allocates a PD with an ID of 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0-v3-76f117ad04f1+2=
8a90-mlx5st_jgg@nvidia.com?part=3D9
