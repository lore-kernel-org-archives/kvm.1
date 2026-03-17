Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4671A313E15;
	Tue, 17 Mar 2026 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765177; cv=none; b=etH6y4f7pL0MxUOynn31wH+usUzul92Ow/SwH1BZMEDkoxHI23IMdgNeT4cvse1kBSh9tU9FIzcaRKZQZ82mvuG8QlWLPxNIkOdxCM+O82tw6G1WFzqAI3f8SIxyVdMRlKzQcXxgkq6N0JwNvME2XSjHwQmIPn21bH1AqEbbSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765177; c=relaxed/simple;
	bh=KBHCdlMIeOd3erUPbLY1mDzjr09dpwVfTy8zQ1wa38o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kX0tBVltYtWRo8eKgRL3Nl6Ls6AyiKB5P6WxPaDREl8NtehROTYPzj9ls8iEqnFs0ntL4sW2F5WyCj/gAyqix92aSn0xWLPHsbJj34llG7F1BQdGDd+2EgULRWpDvW1QWgNpzK1aLNKtsoXbToZYKILOMsXofjufeykzcuHdHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=intel.corp-partner.google.com; spf=fail smtp.mailfrom=intel.corp-partner.google.com; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=intel.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.corp-partner.google.com
X-CSE-ConnectionGUID: QxwCwJH8SFWahRTTllCcLw==
X-CSE-MsgGUID: 1p3Q/dR7RtuZGmq08/Niaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="73981801"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="73981801"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 09:32:55 -0700
X-CSE-ConnectionGUID: d/KcW0f8RuewJwX2r2XDyA==
X-CSE-MsgGUID: vOWywuMdTiyzaDVdvgnUZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="221549933"
Received: from intel-fishhawkfalls.iind.intel.com ([10.99.116.107])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 09:32:54 -0700
From: Sonam Sanju <sonam.sanju@intel.corp-partner.google.com>
To: sonam.sanju@intel.com
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: irqfd: fix shutdown deadlock by moving SRCU sync outside resampler_lock
Date: Tue, 17 Mar 2026 21:57:54 +0530
Message-Id: <20260317162754.3231300-1-sonam.sanju@intel.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316072026.908893-1-sonam.sanju@intel.com>
References: <20260316072026.908893-1-sonam.sanju@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sonam Sanju <sonam.sanju@intel.com>=0D

On Mon, Mar 16, 2026 at 12:50:26PM +0530, Sonam Sanju wrote:=0D
> From: Sonam Sanju <sonam.sanju@intel.com>=0D
> =0D
> irqfd_resampler_shutdown() calls synchronize_srcu_expedited() while=0D
> holding kvm->irqfds.resampler_lock.  This can deadlock when multiple=0D
=0D
Adding Sean Christopherson to CC (apologies for the omission in the origina=
l =0D
submission).=0D
=0D
--=0D
Sonam=0D
