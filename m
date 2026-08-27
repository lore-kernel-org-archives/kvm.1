Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0435C683
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837302; cv=none; b=m514FatJlU5TbIvOI38y2YBj4FOM4k6+j+V7G1ORs54sPMeUcHx8GDQ4kiZNTuiitH824c4FSzoww6IlKVpcvpQoLZq56rcqcZVO628C29EULSC98IdkcyUhjuJL+4KBqn2PQjiliTyDIMaYFtPhpcB8w6q9E6ncU/tKc6cKLf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837302; c=relaxed/simple;
	bh=orW9Qfdi87z66U8ntbpniDPa95C6dYB7h+mE3DRRf6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+1tNIs8HGKkN/wbMvJDiZH85th/ekGbIqfkHry/P8GCjammwmMx2xZB3JT3tkgo7Aml38CIbm1kR7kPYvsRoHLEyRXlqPmTE7O8ZVV3tRvtwjUg4UZ+6hKHPAHzjnD3xT/cVe8hsGmhUem1msf+NNwPbmCENKe/W8CF7gRCVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWTXxhtP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWTXxhtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018051F000E9;
	Thu, 27 Aug 2026 13:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787837289;
	bh=YoiuiV7BuiVkrt8iov95SFQ61pmnoDw60YzzsiWw5ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TWTXxhtPSBhbUDlaXPW8owhBrzMuM51QNTsBlaYj8E3rogpmptJX9wqI6a5830ZTr
	 N5hWNYG/3SL7Clty+bZ11ZgQ3pBlLqE+xWxHydkWV9j38ZEh+0ohY1tahqC2kS+Yy+
	 irlGOnGnIq7yPxzH9joYvSDEGPhnDY0RvDt2tCpvPa0ssydYzuZF29MznUQC4fHfB8
	 T3lzkt+663pSsv+7GLEpmFj/bGsit3k3OGNr3HaTVTtytTpNBDITf/14oBxrAJFXj8
	 /8Oq0LlwLzDu9KPkzTmSLYyC+LNZpm3LGOtOlAjSvWWk4jm2zu+sIlnpHGyjRWqXex
	 743b9W3tF90LQ==
Date: Thu, 27 Aug 2026 15:28:03 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	gshan@redhat.com, enju.kohei@fujitsu.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v3 00/24] Add Realm support to QEMU-VMM
Message-ID: <apA7Y37myawAspZk@red-moon>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
 <apA2aSd4Gcic9vAP@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apA2aSd4Gcic9vAP@redhat.com>

On Thu, Aug 27, 2026 at 02:06:49PM +0100, Daniel P. Berrangé wrote:
> On Tue, Aug 25, 2026 at 04:00:37PM -0600, Mathieu Poirier wrote:
> > This patchset provides minimal functionality to start a Realm VM
> > from an Arm RME capable host using the following command line:
> > 
> > qemu-system-aarch64 \
> >  -M confidential-guest-support=rme0,memory-backend=ram0 \
> >  -object rme-guest,id=rme0,convert-in-place=on \
> >  -object memory-backend-guest-memfd,id=ram0,size=1G,share=on \
> >  -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> 
> This example mentions 'convert-in-place=on', but I don't see that property
> implemented in this series. Is the example a mistake or is this from a
> further follow-on series yet to come ?

This series depends on Michael's patchset [0] as Mathieu mentioned in
this cover letter (+ a fixlet that was added in the QEmu repo reported
in this cover letter too that Michael should hopefully squash in in
his series to make it work for CCA and possible other arches).

[1] contains all of the above.

[0] https://lore.kernel.org/kvm/20260528000416.8161-1-michael.roth@amd.com/
[1] https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v3

Thanks,
Lorenzo
