Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F923168E6
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 02:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784774547; cv=none; b=fKeuQ6RbIvHZ+Wr6q4/oKug4YCo6EIlpp9fm7KFmactewROS19RIoaxD0SLW//Gj28qPX5ne0AhXZcnD6DwDXjYNnDNdrFhBOs93Q92WAx+7HN/GnbSnpRV0v7ecE8ezzLdLHWCh+9EYfa641HHwoltlgeZLD51aldQr+guxUOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784774547; c=relaxed/simple;
	bh=D75lHRFvWmF9lxanQemdnAMDVuUlBgaMm0WdTtGTIqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4+t1pvMUK1weEQPSpcdeNH7Gji/oQzEROK4T4WJSkK1yFzUufHWxRmOvhjXw0Tfyc0Dlvu8+L/Fi/RtgOJy4CW72LSXhDpCBB8RLJ6oSAyIWjUchxEC4SD6eoRMKWBtbtdQINL2ss5bAfem/Y8Xmn3l9PzarPJ+emWRA8I+/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESaeYpjJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESaeYpjJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784774545; x=1816310545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=D75lHRFvWmF9lxanQemdnAMDVuUlBgaMm0WdTtGTIqo=;
  b=ESaeYpjJB58SJirCbLcTZY0E9usczk4WII5RMgIiNjkimjRYcm4cWU9T
   6fEhTHsSia0MG16fNI6yPnjCsfF9vW6SLH4zFWmXy/HmiNI95e6fP/G3O
   HnIGRQfWmzgWdwfdS6sOYEQxOwsGqN0F0PVFcnR+m2bUv/+pT8DtAjN3K
   RyaC+f8Dh4FKGkhue1cEZDfH5XLh1I4bu1tqU3gg5zxoFtNvhXt45TJnd
   eN8iHSo6uMFBSTs1qFJU1qJqvuGo8X7xvQTs/FC9IV+s2BRQCf+BP0P+M
   SE41vufQrSCVCq7+Mev5NYPuTyB45Q5k8hDdkZJRdsLZ4T9Ew9cwBIWGV
   Q==;
X-CSE-ConnectionGUID: btrjcnbzSVKyzN8K1y487g==
X-CSE-MsgGUID: 8PaoEg2/R9Gr7pLSmOAv0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="110965146"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="110965146"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 19:42:25 -0700
X-CSE-ConnectionGUID: IwmRagy9Qdu6Qmig/O2MtA==
X-CSE-MsgGUID: nhRtksXeSUSsmCY2tNiB7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="258962009"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by orviesa009.jf.intel.com with ESMTP; 22 Jul 2026 19:42:23 -0700
Date: Thu, 23 Jul 2026 10:42:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
Message-ID: <amF/jqXf2oWsFrF2@intel.com>
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521145451.1831984-1-marcandre.lureau@redhat.com>

On Thu, May 21, 2026 at 06:54:51PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Thu, 21 May 2026 18:54:51 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
>  gpa2hva callers
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
> (inherited from memory_region_find()), but both SEV callers were failing
> to release it.
> 
> Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/system/memory.h | 2 ++
>  target/i386/sev.c       | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

