Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DF38A726;
	Mon, 16 Mar 2026 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654448; cv=none; b=mKMZQFISJwncN9rwiv5DKul9xb1lE37h/E0y/qWBIiOG4ih0r77iz05dEsVXE2oPh4Bq/ddp7mfwSAxxafzT9PmtlUzCr+GUC1hZj0MPhntZtXHvZvoBGncfyDA/nsZyl94X3MbrAvhJqF2N0B74pS6LwHrOh4aWd+/qgvPYlSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654448; c=relaxed/simple;
	bh=VrilbmZgkwgog72C7HXjL6ppFftQBKHfvJgpY4yau28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6O+LsMRg5LymKC5Q6Z2YJqSp8Ge3Kb0RSCNgSD0mT/MDLyuGDzwyJ8XA0oxobMy34gzqhICGixbpdfECXXZGqGCXoxkCMCZn7ecWhAkCkd/JEf+pZKq5zNAmSnaZX7XRkMsi/mac+cRwOmpZmQMNxOExkfGAld1BF2Zy65ZoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EM3/Q7FB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EM3/Q7FB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773654448; x=1805190448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VrilbmZgkwgog72C7HXjL6ppFftQBKHfvJgpY4yau28=;
  b=EM3/Q7FByNvG6WAWt6AjXcM3BRytPMxliwic3c7arf8bqQD8WJmwANas
   m5a7JMVYFuk3NZFnt6cL5LzcrakgghKwDi8l70kBdRYfmJofLnYZoF7QV
   xBUQxX+UHwPxC5jY09lFMv9ruuw7SfikrJ74vo52TJ0hM01n1I0S++ugC
   55qOXWCaVJMSpAUAvPPWoatDnRcuSLBQXl6lzs4xsP6/d2G98gjLQkY3V
   gE/3wwXcrUgICARrFL5bG1XAmTQRn1o3jirK6j0AYceiwnMoguJPHLQsr
   1MzSW4yFUtk72YRXMmpr7rYtGfyyPC8vurOas7chC9MAlAe4j8wnsmnMQ
   g==;
X-CSE-ConnectionGUID: qTAHpkU9TYmoJOHtNy0CeQ==
X-CSE-MsgGUID: 3OWwa53BRoaWUv5XTg4CNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="97274981"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="97274981"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 02:47:27 -0700
X-CSE-ConnectionGUID: OjFto36fSIeMa0Bpx7vBUA==
X-CSE-MsgGUID: npygykHSTn20Oob+/Ro1dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="217711470"
Received: from intel-fishhawkfalls.iind.intel.com ([10.99.116.107])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 02:47:24 -0700
From: Sonam Sanju <sonam.sanju@intel.com>
To: sonam.sanju@intel.com
Cc: pbonzini@redhat.com,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: irqfd: fix shutdown deadlock by moving SRCU sync outside resampler_lock
Date: Mon, 16 Mar 2026 15:12:49 +0530
Message-Id: <20260316094249.1737852-1-sonam.sanju@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316070802.903908-1-sonam.sanju@intel.com>
References: <20260316070802.903908-1-sonam.sanju@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 12:38:02PM +0530, Sonam Sanju wrote:=0D
> From: Sonam Sanju <sonam.sanju@intel.com>=0D
> Subject: [PATCH] KVM: irqfd: fix shutdown deadlock by moving SRCU sync ou=
tside resampler_lock=0D
=0D
Apologies for the duplicate patch submission. I accidentally sent this patc=
h =0D
twice. Please disregard this submission.=0D
=0D
Sorry for the noise.=0D
=0D
--=0D
Sonam Sanju=0D
=0D
