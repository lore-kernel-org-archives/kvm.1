Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AAC40FDB7
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601077; cv=none; b=HJno/ODsUPg/h3HSpn9/rbf7888dYzLkiX+J2i7z+f0CNyIQ/JdD7/qpPwD0+bGXNQI4SCZwb+4kcJnqRbYv9R7EG9EVWLiBDbt4Hd1zXuTqNH0UKEO8mAejWCqa/U6J+AVlZuh23bpZTZWzWbc4vyO0tEBmloTT8Rd76AJmQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601077; c=relaxed/simple;
	bh=l8LFczawyIL2hbgxZtzJHNxTG99jaXgG5UZqxPKgfGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTR1o4LEF6qfeIjZFjAah3FO02DbM+BjdLd1MY87inBYZeQOn9b8r8eUChsuz8Ab4VlkAlGHyPUpCopRVyJTydbe1pBmriD1xQYhZVKiTONX03YM6EA6EGcJbby9aX96rsnL0dQMCj7Sr48DhImINWNnbnxOdazVOxCxX6TUHEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/R4DtVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/R4DtVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB12B1F000E9;
	Tue, 16 Jun 2026 09:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781601076;
	bh=jSp5eHZidh0sMbQP/hzUILYCljQpS0lv/q9x85VHmCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q/R4DtVncvZSGD8I7IQGl/EA5dbta+qfAhUx0vNsUvZxWa4QWG/v9I3++pR3k/AHG
	 5bUyYZZbmk8A3wRVJetVx+yRG16+EiiVD6ToHhC0UVtkm6IrAxjJfu4EKcC6i1nlit
	 zB0vy8a5PxwPbPUG50bPUuUpatcVPWPma3EidU0qnNz9pr7ayxBjJXWhurdSl1l5bz
	 XJhEWxAeSo3y4XO8toPCZuyd89/Iji5trGvF4FeUBK/zYDGVv4QuEBDTYuecz/MnyJ
	 IC8jIeuIprPcRwtKJkFfyXj9djwaVNvz3dQzhOYvBA2wWwneUKHrNV+bYZBR42ZBX9
	 3mH6chX35bpPg==
Date: Tue, 16 Jun 2026 10:11:11 +0100
From: Will Deacon <will@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: julien.thierry.kdev@gmail.com, maz@kernel.org, oupton@kernel.org,
	jean-philippe@linaro.org, andre.przywara@arm.com,
	suzuki.poulose@arm.com, kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool 0/6] x86 compilation fixes and arm64 PMU
 improvements
Message-ID: <ajETL4tbLa_3WT6I@willie-the-truck>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323150221.49256-1-alexandru.elisei@arm.com>

Hey Alexandru,

On Mon, Mar 23, 2026 at 03:02:15PM +0000, Alexandru Elisei wrote:
> The first two patches fix the following compilation errors on x86 when
> using gcc 15.2.1:
> 
> disk/core.c: In function ‘disk_img_name_parser’:
> disk/core.c:27:21: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    27 |                 sep = strstr(arg, ":");
>       |                     ^
> disk/core.c:39:21: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    39 |                 sep = strstr(cur, ",");
>       |                     ^
> virtio/9p.c: In function ‘virtio_9p_rootdir_parser’:
> virtio/9p.c:1503:18: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>  1503 |         tag_name = strstr(arg, ",");
>       |                  ^
> 
> I couldn't reproduce the errors on arm64 using aarch64-linux-gnu-gcc 15.1.0
> and 14.2.0. I tried doing make with V=1 and it looked to me like kvmtool
> uses the same flags on x86 as on arm64, so I assumed it's because of the
> difference in compilers and I didn't dig further.
> 
> The remaining of the patches are there to improve PMU initialisation and
> error reporting.

Do you plan to post a v2 of these? I just ran into the 'const' issue
myself, so I'd love to see this stuff land after addressing the handful
of review comments I left on this version.

Cheers,

Will
