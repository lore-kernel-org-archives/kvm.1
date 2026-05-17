Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A7B81724
	for <kvm@vger.kernel.org>; Sun, 17 May 2026 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779006570; cv=none; b=ASEWNfwRu02raNY4LwMYT/1bHcezHlwpKxafOJk/A/wjVmK0Iu4MT5SQiuQsiA09mpL1eO+O/NFLTpoeEaJ78l7qSVrYTYpXS15ifHDbZM2Qfw541brqq0KHuW/uCekjrg57v97dvHZi4h89QFYnb4YdubKTa0PmktwpUpREdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779006570; c=relaxed/simple;
	bh=WQP8CDrgulOR6RpcHA3zlhWpcpQhZgsD1IxL7XjMLY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlrXVdyiXzTmFXnLpqg8RANK2SvQmuvhi3O5imTpyOs4b0Xos8v0z5nXFUeGVo2eVjGsadfVYfJw1oAPcIH+G+jrxmaWgzggSsfFT0xjps/VsO36mH5yBNeIPHc+ZjImlQ1MGSXt0/+RskAGkyj7KMQF3sSBIFI24DLGoRlabts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI1QMjlh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI1QMjlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277FAC2BCB0;
	Sun, 17 May 2026 08:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779006569;
	bh=WQP8CDrgulOR6RpcHA3zlhWpcpQhZgsD1IxL7XjMLY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bI1QMjlhG6nVTa/ul1FZJWhAhL7qWwdIBEGX1EXR3Bz+gFTQB+dq8upKQbC8L1W8h
	 pWeljyAUASvntCC24S1SPtXIsoEk8CJ2SzUXMi1OMoqH3/3E4eV5r/XDy4ejZ6/iJ3
	 7KEagk6liYUbVb15LokvFz4POxC3jDrfzSDLlQM8ge/67/+ZTYKyCV3dBxeyR3304j
	 eCR0ukos2CdRh6xmlV5GySfE+tucSqRpBvH9mU+Ra1oemQmtkgJxFFgPwddqsCSvGP
	 nIaAj+18e9EMxR6QJmVv5xt/Ow8tnERP27+hcndSoH+bAmeP2fWKmq2n7DkrjGk3Hj
	 Bp3bLTLlDbVQA==
Date: Sun, 17 May 2026 09:29:23 +0100
From: Will Deacon <will@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: julien.thierry.kdev@gmail.com, maz@kernel.org, oupton@kernel.org,
	jean-philippe@linaro.org, andre.przywara@arm.com,
	suzuki.poulose@arm.com, kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool 2/6] disk/core: Do not modify const strings in
 disk_img_name_parser()
Message-ID: <agl8Y3yhC2tfsDap@willie-the-truck>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
 <20260323150221.49256-3-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323150221.49256-3-alexandru.elisei@arm.com>

On Mon, Mar 23, 2026 at 03:02:17PM +0000, Alexandru Elisei wrote:
> @arg is const char *, but disk_img_name_parser() modifies it, which leads
> to a compilation error on x86 with gcc 15.2.1:
> 
> disk/core.c:27:21: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    27 |                 sep = strstr(arg, ":");
> 
> Make a copy of @arg and modify it instead, and be very careful to free it
> when no longer needed.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
> 
> I followed the instruction from Documentation/io-testing, but I couldn't
> get a virtio SCSI disk work in a VM, I kept getting this kvmtool error when
> the guest tried to use it:
> 
> [    0.154837] virtio_scsi virtio1: 1/0/0 default/read/poll queues
> [    0.156965] scsi host0: Virtio SCSI HBA
>   Fatal: VHOST_SCSI_SET_ENDPOINT failed 19

That's -ENODEV, so presumably vhost_scsi_set_endpoint() (in the host
kernel) is failing to match the device. Can you stick some tracing in
there to figure out what's going wrong?

Will
