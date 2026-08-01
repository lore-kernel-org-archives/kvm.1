Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D8A439015
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583732; cv=none; b=u3F4M/JGAlHKq7NnRyrkYgt1YrGl/MwUyw/Qpeu+PmMnf3JficR5cWvpEKbfpO7b2khbrgATIhhdpFsZdQaCG6A7s+/du4iHBE01B1ZQE6VBZnD4aGD1u42IgxFwv+402N1CwqhPSYLZ594oa7h01Xrcd1v3op7iEdh0wopTpFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583732; c=relaxed/simple;
	bh=dOvQQ4fWhjz4awtbDMg+G37Icy4k1NQ1snwwZ+YO9Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6/1S3EIdLphpKIkvOhvpjuYymdv7vXM6vVdanH4tVfg/x881pvT9YM/wm4EkbEXjjv5UMu0GCUCExhl4LUyXHloHmm+IClJHb0zlQ/xHLtdGT1fkZfviE4LXkvNo40CRlzXawKkiU+XdMGHHWTiL71XcLhKgbvLTNPfQn3+Ca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUUhozpb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUUhozpb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60A41F00ACF;
	Sat,  1 Aug 2026 11:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785583731;
	bh=x820O9K4coS9hT8uHtVNftKKW5pmwFoUaeF2MngRO3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZUUhozpbRnS3Nh6AoBXfSA3uYU+UUU80TRKpXOJnu7eniu9FzMDpt67rZmrVkCE1R
	 5YNk/BoRgf3Bj6gEbM81He55cnwlgLP8DcBdqTzklVY+IVdsKvfCW2FSLSrX0E0Ekj
	 R/3rANRfwW8dH04ksV0BeEHZ65OojdiZThqIkvn6gR4/S+tBh7VBqS27OtuWQYJfNH
	 Fu+YBQF6hZg0c3H3kFnzp9tZJGVwTvCcFSYtzqZdvlHuZFlSX/Co2dCTJBfzyyezAH
	 uACSlR2O7fA7JnXNqxd/u9KDyft+7yASUbnfRUf09RFBcsAIsMs1wVpNZx5k7ztU5X
	 z+0w01IHXrXMg==
From: Will Deacon <will@kernel.org>
To: kvm@vger.kernel.org,
	julien.thierry.kdev@gmail.com,
	Zongmin Zhou <min_halo@163.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: Re: [PATCH kvmtool] riscv: Add extensions support after v7.1 update
Date: Sat,  1 Aug 2026 12:28:31 +0100
Message-ID: <178551725214.364934.6261821697852689480.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714060931.82182-1-min_halo@163.com>
References: <20260714060931.82182-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 14 Jul 2026 14:09:31 +0800, Zongmin Zhou wrote:
> Expose the Zclsd, Zilsd and Zalasr extensions to KVM guests.
> Add command-line options to disable each extension individually.
> 
> 

Applied to kvmtool (master), thanks!

[1/1] riscv: Add extensions support after v7.1 update
      https://git.kernel.org/will/kvmtool/c/391deebb1209

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
