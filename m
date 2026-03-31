Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3B45BD7C
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993733; cv=none; b=AiVskmMYm1+XMmquum6B9Ku+BQItwHp2q9hVKWX44o43t52txV+dx1OT5UR2HNH8cKJzUqAc/+PlWtRC2qUiwAZp76Ozfpw+bNkevN/hRoVUgVPHwOlPbhpUrerWZKR3cs9sYmiT/8xOiT9sQO2qAH16uON8UBEJ2SH7+5dAk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993733; c=relaxed/simple;
	bh=xjBK0mzjHlXWnIev6nElepTIE4coNcu8WYAmBIYGbfQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=piCYIAI2z6CVGjygYRXyvBw9WMtcxVwYxUFuLa1K+4QStp59pGTSqmWlG1G86GsPpzNR57l1GN1fzeYYkVMCiEItD6g1S+AlpWWBrH3d/kN1Vu2eyE5JKTkYUGWQSqk6t7FA3EiK2i/EEvmUZAA9M+GB4HQ3c2CUQtcJ4CSoMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCzz/Hdg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCzz/Hdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E37C19423;
	Tue, 31 Mar 2026 21:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774993732;
	bh=xjBK0mzjHlXWnIev6nElepTIE4coNcu8WYAmBIYGbfQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=qCzz/HdgYcH39k1/VusVZCROEG7QF5n4Oji6dry8xZBEhuIDpSQkI3ByDOSCVdjpL
	 J8Jcw53sGQNGo2hw4pvzPblGnwnLWCiSNw7EG2b7gG/npfMsQ37NuJW94iLZ7jwVpN
	 AbGsY436baupmjavEr1YjIe9b55BJ2L94YbcJ1T0/gic2rgRQv1Q4M4oCEpsCobe8X
	 P79WBwGCKqa4xovAgEqOR7xHMImeKa9ZpvvHuykVUdUUIqZqVJ+wVT5A/HO8o7DbaQ
	 xCO8UlkOcaAgLvXLWAJVQYVYM0EzZNlp8uMge5kBSniP84AGPPBUqnQiO3jqUmp8tE
	 ykpUyH7PTZTrw==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 31 Mar 2026 23:48:50 +0200
Message-Id: <DHHARIP50BM1.2DW62G3K7DDI2@kernel.org>
Subject: Re: [PATCH] vfio/pci: Require vfio_device_ops.name
Cc: <alex@shazbot.org>, <kvm@vger.kernel.org>
To: "Alex Williamson" <alex.williamson@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260331202443.2598404-1-alex.williamson@nvidia.com>
In-Reply-To: <20260331202443.2598404-1-alex.williamson@nvidia.com>

On Tue Mar 31, 2026 at 10:24 PM CEST, Alex Williamson wrote:
> vfio-pci-core code makes use of the vfio_device_ops.name field in order
> to set a default driver_override for VFs created on a user-owned PF.
> This avoids default driver matching, which might otherwise bind those
> VFs to native drivers.
>
> The mechanism for this currently uses kasprintf(), which will set
> driver_override to the literal "(null)" if name is NULL.  This is
> effective in sequestering the device, but presents a challenging debug
> situation to differentiate driver_override being set to "(null)" versus
> being NULL and interpreted as "(null)" via the sysfs show attribute.
>
> There's also a tree-wide effort to convert to generic driver_override
> support, where passing NULL will generate an error, resulting in a
> WARN_ON without setting any driver_override.
>
> All drivers making use of vfio-pci-core already set a driver name,
> therefore by requiring this behavior, all of these corner cases are
> rendered moot.  This is expected to have no impact on current
> in-kernel drivers.
>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
