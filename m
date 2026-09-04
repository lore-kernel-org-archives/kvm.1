Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB8390214
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 03:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491389; cv=none; b=ibJe4aDO4KTCFI8rIaoBK5tsF+hRMbQ/mUKl2qYHi534UQS39hyleJJGTCDQtNQKh2w0PXqfClA6jEKDOXec0rEZS7ojXuV3mRNx4W/9kYPyzR+WY/2Scy9aFWePHpE0KoROkOAqJIWCQYELoD58q4VFKhFKy60Edd4eMxpbJVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491389; c=relaxed/simple;
	bh=9Y4wgbNgAjv+eE+KIA/oCpZuJVblXsW/G+HiW1/93os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sx9UtbOygy56OwFzj3OzvOaI9n1wF67phpKPq5tD0tzeKS6pmtPd0R1Ih8+eESRr6SdkQRKUjxqlxS+Gsdlaac99cGZ1JKUyHyqlTnbJQaZPhAeu7a7OjXZR1FighPkNzMOspUqPwHLgZOulLijamqksB0cICw0g4u0jfRWPMs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=dGC+Gm3q; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="dGC+Gm3q"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1788491392; x=1820027392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Y4wgbNgAjv+eE+KIA/oCpZuJVblXsW/G+HiW1/93os=;
  b=dGC+Gm3qANMxT9S7gLsSU2jE6HOng5SdpuHb5lH41xYz0tIId07a1FSW
   Zxm0qTy4ok1f+SrrTLrjnsz1/RrnDrObVqqCKVm/TCnJ+IaFWRSOp62VZ
   5zjMzJo1aw6A1o7b2cnhX3N2ntvBBv6K5S8rfmTpWuqdH+o1llQYst6SF
   MvdQzLd6iYUYZf8H2K6ESlAmDJZ/SliEjTEwcb3L6VfN9MSuGVMMEGRzs
   W1yGANmmecOf+nom3LBdF7n7BazzmKydRKXC3NvNdRTH50mI4gL7JvpgY
   TYc+wJWX79YDttzLc3E3OIpO+N+JPj52uBUVNa8dWSsf9LuIMtt5IAXG1
   Q==;
X-CSE-ConnectionGUID: y+8MXciUSba8muPBVeh4+g==
X-CSE-MsgGUID: UlHP4rZqT8WpulXOnwcs3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="253827394"
X-IronPort-AV: E=Sophos;i="6.25,260,1779116400"; 
   d="scan'208";a="253827394"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 12:09:44 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 4A1CD1002B88
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 03:09:40 +0000 (UTC)
Received: from az2uksmom4.o.css.fujitsu.com (unknown [10.151.22.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id F4166896E2A
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 03:09:39 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.9.19.125])
	by az2uksmom4.o.css.fujitsu.com (Postfix) with SMTP id 1C2954045ED;
	Fri,  4 Sep 2026 03:09:33 +0000 (UTC)
Date: Fri, 4 Sep 2026 12:09:32 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com, kchamart@redhat.com, 
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com, 
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, 
	lorenzo.pieralisi@linaro.org, gshan@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
	kvm@vger.kernel.org
Subject: Re: [RFC v4 07/24] target/arm/kvm: Create scratch Realm VM when
 requested
Message-ID: <apo185JSe61bK3zm@FCCLS0092175.localdomain>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-8-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903193611.1058589-8-mathieu.poirier@linaro.org>

On 09/03 13:35, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When a Realm is requested, create a scratch Realm VM by setting bit 8

nit:
KVM_VM_TYPE_ARM_REALM is no longer defined as 1 << 8, so shouldn't this
be updated as well?

> of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
> for the guest PA size.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
