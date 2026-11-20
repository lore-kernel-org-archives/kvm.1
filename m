Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164733;
	b=SRsS1Z5mTsqzhaYnaeCAVfPE3U/4T1RaSFINsjIcZkew8+oaLqDUsdLC3ORNKgkNthie
	 NCyCRMJduC9E6srk+xMm+hTLgB7RPdYato85Uy8l0LTV9S5dxBZ0df2e/kX8+GTudWpBx
	 5Ijz9RwoeeD7i+6Yn0sh4OcSvkQ0kMD/StIfHGjJWOACHL39kYxwcCtFDHTWaTWdkyoPp
	 5tNLHlnO5E1rNC6bOFRn41YtkY71AR0e+RIXylkedkdG4L6imP2eygsxmraPu/8xvOacC
	 CLjiujfyqgi+M+FAB3naWGP+uYoDnLzqBNjddtPK4cN1fKiRjMgVFm9GEINid8iz2Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164733;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=A9BupMtjidZ6QpobbhfwIfHs0MvSJr7PSNCGLjThNjE=;
	b=BIC064aoXAvX+c9OnH2Ab4i36MVTBuAIee92+XkOsO/U1beAD++zXYwoWcF0nVJ1cxMf
	 xrsi+krkXYtmNd1jx62Gw6/PV0ZFFON4IheCf3PalJ03U/kt6XYTJ+9e0vDayFLuZ3r9N
	 1drZVuyXTDq/W4rco2GXV1ajrIhdpX1KtV2GLCeTwbIXpmmOFX854jf5nJJ3wLvuayuyZ
	 6mVwam72+m8NHGqLJQ2ExRYuDtpkB6VUpXgHd7RbVKH1nZpABjJgdvq8m69E50hC2yoTs
	 nuXnTVvk/6tpS0e+LqQDbdLOfCwHqXuyjyp3UC3iVcpB+/DxJT/qZhnCJwNNLtR0AoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UI7RZ7UG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477E606A337;
	Fri, 20 Nov 2026 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UI7RZ7UG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC441F000CA;
	Fri, 20 Nov 2026 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795164732;
	bh=A9BupMtjidZ6QpobbhfwIfHs0MvSJr7PSNCGLjThNjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UI7RZ7UG4ulO+8lDySyolGDohe7qVwBRm7JU4jcE1PzwxsuPIW4enjpXJ9hsRxlwA
	 GRfeYk3l8bnxjuvd8SRFpRzbhXWUeuu4O9DMa+/XYZxEMrPWt8vHZLCFJMRuXj71Av
	 0DnRmE153jsvcLlDVr7/T9O3PK+k5DFgFchuwKhFw7RDyTmZBvCymZcSWx9hzZxpew
	 dO/8tAnz/RUNZPCobsNfix4h9APM0Si1UkEBYDXvKJy+BOlncANRePBbTWC596NoYV
	 tpFuegArNVwixEy/6ldDxBRwXWh8fJpOM0sUyZGI+uB97L5vP/WhjK2YYHWvdy1RXI
	 /8BjfbVmtIAQQ==
Date: Fri, 20 Nov 2026 09:52:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: ackerleytng@google.com, Alexey Kardashevskiy <aik@amd.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, David Hildenbrand <david@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Fred Griffoul <fgriffo@amazon.co.uk>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jianxiong Gao <jxgao@google.com>, 
	John Starks <John.Starks@microsoft.com>, Michael Roth <michael.roth@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Sean Christopherson <seanjc@google.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tarun Sahu <tarunsahu@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH RFC v3 03/88] mm: shmem: Implement guest_memfd provider
 operations for tmpfs
Message-ID: <20261120-provokant-zyklisch-schutt-55d8eddf2ce4@brauner>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-3-8484dde66a7e@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106-gmem-alternative-providers-v3-3-8484dde66a7e@google.com>

On Fri, Nov 06, 2026 at 04:36:37PM -0800, Ackerley Tng via B4 Relay wrote:
> I put guest_memfd_provider_operations as a pointer in struct
> file_operations. Being in file_operations generalizes well to other kinds
> of providers, like devices, which don't have their own super_operations.

> @@ -1960,6 +1961,9 @@ struct file_operations {
>  	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
>  				unsigned int poll_flags);
>  	int (*mmap_prepare)(struct vm_area_desc *);
> +#ifdef CONFIG_KVM_GUEST_MEMFD
> +	const struct guest_memfd_provider_operations *gmem_provider_ops;
> +#endif
>  } __randomize_layout;

Sorry, no! struct file_operations is not the place to hang KVM specific
callbacks off of. We didn't let KHO/LUO hang an ops table off of struct
file either and nobody else is getting one in file_operations.

LUO registers handlers that recognize their files by f_op instead,
memfd_luo just uses shmem_file(). And KVM already does the same for
VFIO: kvm_vfio_file_is_valid() -> vfio_file_is_valid(). Do the same for
providers and leave struct file_operations alone.

> Setting it in shmem_dir_operations allows directory file descriptors
> opened on a tmpfs mount to provide memory to guest_memfd.

That is weird. A directory fd is not an allocator handle. The folios
aren't backed by any inode in that tmpfs instance but they're charged
against its max_blocks. Which means statfs() shows space as used that no
file in the filesystem accounts for and that you can't get back by
removing files.

And also with CONFIG_KVM_GUEST_MEMFD every tmpfs directory on the system
gets its own file_operations just for this?

> +#ifdef CONFIG_KVM_GUEST_MEMFD
> +		inode->i_fop = &shmem_dir_operations;
> +#else
>  		inode->i_fop = &simple_offset_dir_operations;
> +#endif

Afaict what you actually want from tmpfs is a mempolicyj a size limit
and noswap? guest_memfd already has a mempolicy. Teach guest_memfd the
rest instead of turning tmpfs mounts into a memory pool?
