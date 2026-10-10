Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391B3E63A3;
	Sat, 10 Oct 2026 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791628894; cv=none; b=GMHPQ/fHqfuz9asGKiebyPu2OIdNfpxsp+dNSOyTRM8yzrDX77LJE/BSzGwdVZLhb3jQUvlveSDEWdKVXQaoI57tNbtYiV0Y7M2g1avg1iHwIVvY+J++fjaB9l9J09Qnn6ChhNoj2sJwEgeRAZaNRShdpfJPw17tEcGkMq+9yhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791628894; c=relaxed/simple;
	bh=kaswJ1q3+BIre+GUKNhVzuiTeFro3h0CGTufiL3bZy0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=kZCT5HaVIC7pnNXXJ2fgaxYXqH9eHn5ilgwNCHlvGj0e1hfxGkpxh5s7zqG2yiL3uiM9RLtvW0XOXa8KgWfFxcI33v3Ff7j5yY5anWCKB2mlWwYhjwObk7/XpqcLh4SQ8kBrgRDNS1dV6/H/ficHyRAB2YPbOtwhbDGoTeOCeQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+kCxjiN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+kCxjiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427381F000FF;
	Sat, 10 Oct 2026 10:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791628892;
	bh=G3xpL7s/1b3vxoJ9yTg6aceQTVFgzQbmWY97h8uEOWg=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=N+kCxjiNOL56IeFx4VnUgnaw4H8Ofp8K4ISrASsiDJZ2R1VVLchkNF06FGf+Y8GF4
	 hAMYz0B8lXfGiclB1T/uYWuShcc0Bj+WntiOuRZVjBhWb26beIDmVS8JXfgd18TwDG
	 RT61H7e6yS3ESfjUlL4AjhvgwfUVxI8NNTKIlvi4xkXOkfmKtD1wp+n9rn6VAC9VIv
	 H0Q0o1EJLH16HfrWRcFRmy8Cz0DbRt9LxPVBv/b3C8BQPKvDHAJsUTg2OVAarLgw2h
	 e3kb3AmdxONq8POJHKZ1Kwk8EnX6ew1fM6FVQ0WX2VwgM4RmLR2mSzn3MOMs6eNo+W
	 LsTkzIlCGNRwQ==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 10 Oct 2026 12:41:26 +0200
Message-Id: <DM13FNZABHU5.2FPFRL5FG2WFU@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 1/1] vfio/pci: Remove the core dependency on driver
 data
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Simon Song" <xinmengs@nvidia.com>,
 <acourbot@nvidia.com>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
 <kevin.tian@intel.com>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <zhiwang@kernel.org>, <zhiw@nvidia.com>, "Alex Williamson"
 <alex.williamson@nvidia.com>
To: "Alex Williamson" <alex@shazbot.org>
References: <20261005184236.1946167-1-xinmengs@nvidia.com>
 <20261005184236.1946167-2-xinmengs@nvidia.com>
 <20261009192800.GG13920@nvidia.com> <20261009151821.461dbefa@shazbot.org>
In-Reply-To: <20261009151821.461dbefa@shazbot.org>

On Fri Oct 9, 2026 at 11:18 PM CEST, Alex Williamson wrote:
> To apply, the below 3 chunks are dropped in their entirety.  If this
> looks right, please someone double check, I'll apply it.

Looks correct to me.

Thanks,
Danilo
