Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636DA2367D3
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097870; cv=none; b=KCZLRF+liLcBR/PVR0x/ytl0EHXbxVjz55bDlsq6KN9NS/lZBBYBSKKHBiIoMONhsh1bKv4t5V6EdFr8NUS5BRPy69vEs+6kosWRpTVefLu8eSu9hEOCpTuXnMBczpH8XuWKJK9lPw3sqX6UpTHJGZbimCL4Ofx0KMzAfFb/Bow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097870; c=relaxed/simple;
	bh=56ErnD2LQdVS/NgEzVDik991Bpg/9H86RuRNiovlXV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6Sk0B8bgaz9eyWCcfB+eCtwGjdlEDYgpau7KlHJtdviC+AK1wMbn7FzAsWfyRFV6XH6h8Of0+0qLlL/oKldHk1ADej3ZFWNrUi/IlBgDHE1ElxN4yet+wIC/PDpy1NNx2W2T2qxpnw8ZIRDdhM1HdSlAZk2Ge9luCxasutIsy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YsFXV7TC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YsFXV7TC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CB512328;
	Mon, 18 May 2026 02:51:02 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 950623F632;
	Mon, 18 May 2026 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779097867; bh=56ErnD2LQdVS/NgEzVDik991Bpg/9H86RuRNiovlXV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsFXV7TCIaMfqTDGWxwe0/Yai9R8Q7/0FUob4jPGYX25FJBCpoOtrNnCib8uYYQx9
	 8prcURfoDbB7Tt2Ai+jWnGo5ZK3vr8oEGdSO4H4xzddlzzsI3XylEJQraNJOsb+88u
	 1+bkmWyERP+3tEoidJNK+cxtb8ZYYSejf3luycrI=
Date: Mon, 18 May 2026 10:51:02 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Will Deacon <will@kernel.org>
Cc: julien.thierry.kdev@gmail.com, maz@kernel.org, oupton@kernel.org,
	jean-philippe@linaro.org, andre.przywara@arm.com,
	suzuki.poulose@arm.com, kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool 2/6] disk/core: Do not modify const strings in
 disk_img_name_parser()
Message-ID: <agrhBo3TW7lKQY7R@raptor>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
 <20260323150221.49256-3-alexandru.elisei@arm.com>
 <agl8Y3yhC2tfsDap@willie-the-truck>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agl8Y3yhC2tfsDap@willie-the-truck>

Hi Will,

On Sun, May 17, 2026 at 09:29:23AM +0100, Will Deacon wrote:
> On Mon, Mar 23, 2026 at 03:02:17PM +0000, Alexandru Elisei wrote:
> > @arg is const char *, but disk_img_name_parser() modifies it, which leads
> > to a compilation error on x86 with gcc 15.2.1:
> > 
> > disk/core.c:27:21: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
> >    27 |                 sep = strstr(arg, ":");
> > 
> > Make a copy of @arg and modify it instead, and be very careful to free it
> > when no longer needed.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> > 
> > I followed the instruction from Documentation/io-testing, but I couldn't
> > get a virtio SCSI disk work in a VM, I kept getting this kvmtool error when
> > the guest tried to use it:
> > 
> > [    0.154837] virtio_scsi virtio1: 1/0/0 default/read/poll queues
> > [    0.156965] scsi host0: Virtio SCSI HBA
> >   Fatal: VHOST_SCSI_SET_ENDPOINT failed 19
> 
> That's -ENODEV, so presumably vhost_scsi_set_endpoint() (in the host
> kernel) is failing to match the device. Can you stick some tracing in
> there to figure out what's going wrong?

I am pretty sure I made a configuration error when creating the scsi-disk in
userspace. Jean-Philippe was able to run upstream kvmtool (without this series)
with a scsi-disk with his setup. I'll try harder for the next iteration.

Thanks,
Alex
