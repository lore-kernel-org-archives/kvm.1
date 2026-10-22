Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660305;
	b=3ropeYW4Wiq1EKu7vfjinaxKg7yE0Im+NAgolk283y5I51AOBHRo6uB8990eG8wttI26
	 ZyiTScoSZ5oEv/yqi1FGnmVkU1yB3E3TCO4efSzqOGH/kKUE5aKZTNuXR1leuDZMC42/U
	 aPYuAJLCVtR1zadi7rg43nbuqKCsSJgrrHSe8udzx404YOW+wrgQ+fua33MR02/6V3Nxh
	 g/fosAiGPSN90IQP85BMy0QvMSzGL87GqjAfadRJB9c5ity0D+BVtirukpeqg6dqYwA6x
	 Uvuv3/VqBIA7TqnMpuyqXCu/sAektDW9eq70OX1HI/8ayaAE2F7jboEs5AKdOsFnNJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660305;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Ua5rqS+M66UnjBJ5kQcrA+aCzB6P+WQ6Ck+EetFcnug=;
	b=KUsZaul1ysFsFePuIpcsnfE7chzHOj7RA5qHxe3d+PWf0HHMKb/3BiJNfdbzABbRGTnu
	 cS2bW0bmQze3QdKwScpV6cyHBNxJs0VD6z4TGTA5tNzlbeTGPeh7XZjsdupwAmfcDm9Hy
	 0DrEdJuF9UQNmjXNPr05T4q4rnHRgexdpZOYEyufZqDm8nbaDk1gLKiPjZoaq9RgdLQz/
	 n1spFSOT4FjaQt/NWO0nXHfeMt2G7xtpxagtFptEjK9li5ddJkB8mP3dEArr7kcMamx0f
	 Mu0XtM5f1h78HXGzQOFVMgcPEkFKuNF+824RsZ0mbooYt/XKHwizA3sIB1IDQ5Sayvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vb33JHXW;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74642606A32E;
	Thu, 22 Oct 2026 09:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74642606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vb33JHXW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792660305; x=1824196305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yUO+03PCzKOpPATkFdI7CV7q8rqB524brlL+Inf/GGQ=;
  b=Vb33JHXWDZ+btzb3Y/LPIIoqPCa71EXKm2NEisO+6F/wU2SiGpf3N4st
   Xwtu4Thg+2DiSWvbAD/VtfckmRYNghpWGm1swWnYeld6WKynWPUtDPtlW
   1fsEANB7c5txC1h1xZ2Rs85AhOiutCO1pDJo7X3y5LrUUrIYN0Xt7PuQ/
   VzRpyRGN+QhHBkaYA+7sYCWQD9fdkkISy86/eCy+WUS8WIm8fSPK/i0O5
   WCcbksVG83buptNzlntPnMfx/w+zBAG40aDe8B0+Hqlo2NgE21vDCajZB
   841YwIFB4yxoXF17qTCk/HJHVCcUEkW6mj9tvMmAV5j0bW0Th3CfsxrZH
   g==;
X-CSE-ConnectionGUID: 620vwITgS1GQZGMdWuAJ1w==
X-CSE-MsgGUID: Y5C4jojiSWq4E9Rk9lYgsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1283920"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1283920"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 02:11:44 -0700
X-CSE-ConnectionGUID: 22dxuheFTfSMLW4D/oBpIw==
X-CSE-MsgGUID: FvWKl4wJTo+dHODHyBfxGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3328115"
Received: from wgawrons-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.187])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 02:11:39 -0700
Date: Thu, 22 Oct 2026 12:11:36 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, seanjc@google.com,
	x86@kernel.org, kas@kernel.org, adrian.hunter@intel.com,
	yan.y.zhao@intel.com, binbin.wu@intel.com, xiaoyao.li@intel.com,
	chao.gao@intel.com, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, nik.borisov@suse.com, yilun.xu@linux.intel.com
Subject: Re: [PATCH v2 0/2] Drop unneeded cache flushing
Message-ID: <atnTSJ5bDb5OxWfE@tlindgre-MOBL1>
References: <20261015191710.3632302-1-rick.p.edgecombe@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015191710.3632302-1-rick.p.edgecombe@intel.com>

On Thu, Oct 15, 2026 at 12:17:08PM -0700, Rick Edgecombe wrote:
> Hi TDX developers,
> 
> Can I get another round of review before we ask Dave and Sean to look at
> it? I'd like to pick up a few more RB tags.

Thanks for updating the patch description, for both:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
