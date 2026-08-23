Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BAC2D9484
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787475102; cv=none; b=kXED5JrOR6qbYJW0S2xAL4NjWaVCI8ywzqLYgZuKbTJCS+0i1pGni5XcnMgLopUGVA9NuF3nO1u6khKH0kiuLIetYmHQkXiVXm4/BbKqugjDeOGg18bV7ZJ3HF3R05vuJCyNZItpKs7ivF/SD2lRtP5I9Ecg/PRKHzNtMHOO4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787475102; c=relaxed/simple;
	bh=HsTvkY/tzGD7MqW7u4p4m7bQaDv0rZcBZwz9af28cQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SduVNNb3ek0Oypey5DPc80y1bVxPIFt4NujQezzUtAAz+D1BOk+e5GKu+IKA9pLNIaC8tkzGuMIhkdXnuVOydhXo905uefBDb+2tWjIkq69v6T7rNIYTvpzXakqQxTAibu/FIxOd9FLwSOulvpF1hIEGVpQ8WHnFfIpzIjA7e68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsonJ1/z; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsonJ1/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787475101; x=1819011101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HsTvkY/tzGD7MqW7u4p4m7bQaDv0rZcBZwz9af28cQY=;
  b=OsonJ1/zT1uC2zwC7Z5vBJ5wUyia24WywD7Fa6FB+Gwq6Q7APFYjlBd7
   rVkS5GjclKlWvQVTVa14tYVy9NLZUcSrAkwccFVsbZQNbFUVG1l1T3nw3
   1drMsf7poKusQXD+Lohh27CSxVABC4PNum6I/roehiwiDBhsZ2wgXTqAv
   LhOHBTTfIQXmw/DFRV+rUYzpudxTZJ34+YdFWYFWwphNCX1yXUfogY5ho
   PISIhbqQswSZypm98YdrW6rx7KAg7LMBgCKXgxDvcy8VHH/5+dubhi0y5
   k/em+oec3D1/Zlel4cYq3yJrkMcT2rADfFB2hJtII71v9q6n/dZzZYMb5
   A==;
X-CSE-ConnectionGUID: zdAKN+tcQmuTOsMG7LYHxg==
X-CSE-MsgGUID: AFzxpkkAQMquDKkcwIkNAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="75493392"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="75493392"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 01:51:40 -0700
X-CSE-ConnectionGUID: 3+F6gzEpRwujlESadOFDJQ==
X-CSE-MsgGUID: 9hS8K7LwR/27DfzpIIke7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="271945648"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa005.fm.intel.com with ESMTP; 23 Aug 2026 01:51:38 -0700
Date: Sun, 23 Aug 2026 16:51:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 4/9] target/i386/kvm: Use AMD MCE status encoding for
 Hygon
Message-ID: <aoq0mWqm44i+4qw9@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-5-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-5-zhang_wei@open-hieco.net>

On Mon, Aug 10, 2026 at 04:29:51PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:51 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 4/9] target/i386/kvm: Use AMD MCE status encoding for
>  Hygon
> X-Mailer: git-send-email 2.43.7
> 
> QEMU's KVM memory-failure injection path builds synthetic MCI_STATUS
> records for the guest CPU.  The status encoding is vendor-specific:
> Intel-style records use bits such as MCI_STATUS_S and MCI_STATUS_AR for
> action-required events, while the AMD path uses the AMD memory-failure
> encoding.
> 
> Today QEMU selects the AMD status encoding only for AuthenticAMD guests.
> Hygon guests should use the AMD status encoding as well, but currently
> get Intel-style injected status bits, including MCI_STATUS_S and
> MCI_STATUS_AR for action-required events, and a non-deferred
> action-optional record.  That can prevent a guest OS running on the Hygon
> CPU model from handling the injected MCE correctly.
> 
> Use the AMD injected-memory-failure MCE status encoding for Hygon guests
> as well.  This does not depend on Hygon exposing CPUID 0x80000007.EBX
> recovery features such as SUCCOR, and it does not advertise any new
> recovery capability.  The change is limited to QEMU's synthetic KVM
> memory-failure MCE status; it does not change CPUID, MCE bank state, or
> migrated CPU state.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/kvm/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

