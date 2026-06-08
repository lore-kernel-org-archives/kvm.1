Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41608312832
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933536; cv=none; b=roIMZloFAD4ovMCblv9J+UDgMCYH1fhzNt+bv9OWftFqb3yNXaH2YxJPYtXCSeUW5mT8G8NpSJlloT7vBXqvWdb4AA7GoY1qll/+fBoI++YaWpYTGiXHrf4TRNd85BejrVaODjx1iwshcVvspiY1OEGrodnxx1uwrZupbZY73XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933536; c=relaxed/simple;
	bh=/ZRUYQ3Qiw/BIZ/qrmsWY1dhK54RSGasZuBgu2EpNVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJt/LgcXFQYBuJE5RXOVFW63RU2V63vTThkh5eqGMjN8/a7IrWiDOBMRnM/6HWJGhJ/oQYVVLxSKHmGOPxVc8Q/Mpq2UtRmaMcB2Ziuw9oJAV7WsYPPmT45p0+5rlXyS4Z/lAJrP9DnXxtxJZaF1P4Wk2yHAA0Nfghx+oqiV73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2660F20243E;
	Mon,  8 Jun 2026 17:45:34 +0200 (CEST)
Date: Mon, 8 Jun 2026 17:45:32 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org, marcel.apfelbaum@gmail.com, 
	zhao1.liu@intel.com, mst@redhat.com, cohuck@redhat.com, mtosatti@redhat.com, 
	Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
	coconut-svsm@lists.linux.dev, joerg.roedel@amd.com
Subject: Re: [RFC PATCH 00/10] QEMU Support for KVM Planes
Message-ID: <aibi-SOE-eiBZ44K@8bytes.org>
References: <20260608152109.356783-1-joro@8bytes.org>
 <aibiXAlJtbZdGdHl@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aibiXAlJtbZdGdHl@redhat.com>

Hi Daniel,

On Mon, Jun 08, 2026 at 04:40:12PM +0100, Daniel P. Berrangé wrote:
> How are device-plane values intended to be chosen by the user ?
> 
> Is "2" a value that can/should always be used, or is there a dependency
> on the igvm file, or somethihng else ?

Currently it is based on how COCONUT in the IGVM file it built. It will launch
the Linux guest at plane 2, so all IRQs must go to plane 2 as well. For the
future we are considering passing the device-plane value to the SVSM so it can
decide on which plane to run Linux based on that value.

-Joerg
