Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19FD3C378A
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539143; cv=none; b=uMKo5Yn7zGzNm0lbcGv2totT6btcTX4tYJpRVqOGWwaMVXMcFB7DSj3XkzPfQQUcmD56muycu3KDiPgKPHMDnuhqLvJggobsbV56qRdDSiQdgQ+iLZdtGQse8nDVO25Qmm9NYjCXFUsn6TbcYhlPVAZZBXIOP0l5GLNjNOzy+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539143; c=relaxed/simple;
	bh=fqcX0hawjXfDopx3NhdYKb9DcbugXtywOI6nzju+nDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2Ub7B/GoN2uQ0begfz7//yTFlEKfubKWsRREb85Fay3V9uEC2fIq9ewz1xwNVc60JLioVoi9vYEuZhSZoVe1akCov6u0nOIP4cDN115yEFTkdrT74onfAomkNM+YQfhGgbaAMt/Az0AGincAKYH8RWqSTvU771pPOFhAhEsgUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V6JO9gfG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6JO9gfG"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-852c481415fso1151377b3a.3
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788539141; x=1789143941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EoggvHQ/cuPoPSyx5k+9q6Wpui3ScOQ6Pt0lTizqruc=;
        b=V6JO9gfGDzrOn8V79+cNcerwj1oNrqVVPWdr+5eIECPmxWxObLYjgIS3p7N9t9fnbd
         LIeQy8FqarB0nWgMogDh53gozzwf73OoSE5AR6gjGstoNZ8oddTuGEo5qIgILoQI1Jyo
         OTb4PjKGaSktnEoMlngOq5/0gySCs5MJWKpxj4rsl8MGEOg5fegBmPASFkEUu1Iw9kyY
         r5B6O+UR1gUlLLjTaaT8zkeDXWqGve51JBfskrHLLf1rwP/nInIwMNZLiPjskLM47zrd
         KieLV7MRax8bZHeqI6MSdY/En/cU5kyz0QfjvhyLDqT7qEXuppCZ9maeH0mBNKM3jnrj
         0jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788539141; x=1789143941;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EoggvHQ/cuPoPSyx5k+9q6Wpui3ScOQ6Pt0lTizqruc=;
        b=cmOegZurUT0SCNZAHl8QF2L5fnPgV/ehEV0zDg4u05z0asDw3aFSR5wForM2f9KbcU
         Fh+xMIouK36jRs+PcvYZzOGecjFRB44aGO1aL+9JLIpgqU/T0UXKD0jLNQ38UuhA2DgE
         lQotUx4k2RXX14R6H5ZKwrVf7CH+iuLI7WCTbzRxh8S7jB0RQ8oTi/GLIdQvGHJjecT/
         90H+0v1f0HcIjA/hD9hHf+nsmIWWYjIYLKI1iQ5cFb5R/yuFAjZLmUkYutYRyTzOvnLq
         QlYTJ3BuCxQr051AkOpu/F9qQt05yeZ3zR2Mhs8iet4ozA6QI2pLy7e0qHB+UxEd7JkI
         gP6A==
X-Forwarded-Encrypted: i=1; AKwUvBzzdc2yDQWetrPEM8LN/dV0WAVgy7JDN/yD7TAUfRt8A2ZhZmbXIMd1dC791uuppk7Jr8o=@vger.kernel.org
X-Gm-Message-State: AFuF++nJcONxbOBXw/5O5PaHR9ipT3w2avPKP+itYqtlbnEihsovtDxP
	FlZekXIwwTFJ2wf1RUPXL6qIoSlS+6myQVmR5SmFCqBzj+/9gv7kMdo2P+4XUtU1Vw0=
X-Gm-Gg: AYBFou2dE8WJyBzFlW3KhunYIxNvj272vElf8fXmqpaH1ne+E99McQncoLR0jN8qMhT
	BYFJS0fgJgIKjHnGoVvCV0vf3jsO3+MN9ct7TTEZLpaF/H77c56yzUdbaJGwY/0jGKRUg764dwW
	PbJ0nYihr4UvnO6D8ozKUeQdA0JWYErovxBCnvtPxHZHZKppuv4h3SxzVEB9lVZLNpCK8Dtn6xK
	QzRjjW9EQTPxo1A6X2NrtZ08pjQuM2htqKyDD0eKtWjqn1njBpPcl066QcKAr0iF8s7oZ2zhdSL
	q42y9Morx63ZBZuPjh0bwkemvfc7H5uYDNUz2lGDrNF3txBVQfJHhqkdvGNGzLPp+tAd2Xv6P1c
	A2wP0kyF97mdoeE9pFH7f7749f8hNwp7jGV20pUs4VDPgZF/t1HlXR2SsiIQXVnmqMy81mBRfTn
	d/Ap5Z7/Ms8uTQV8NUcdjQNZmDjPYJgM+76fRLGZbPboLZ/YNmhwdO5uNHOaR6AOv7
X-Received: by 2002:a05:6a00:1c97:b0:857:db2:222c with SMTP id d2e1a72fcca58-86168b8719bmr9475111b3a.9.1788539141081;
        Fri, 04 Sep 2026 09:25:41 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:f95f:75de:b3f0:3bf5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152045f74sm1377683b3a.10.2026.09.04.09.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:25:40 -0700 (PDT)
Date: Fri, 4 Sep 2026 10:25:37 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	gshan@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v4 07/24] target/arm/kvm: Create scratch Realm VM when
 requested
Message-ID: <aprxAYZzTOS9lPth@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-8-mathieu.poirier@linaro.org>
 <apo185JSe61bK3zm@FCCLS0092175.localdomain>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apo185JSe61bK3zm@FCCLS0092175.localdomain>

On Fri, Sep 04, 2026 at 12:09:32PM +0900, Kohei Enju wrote:
> On 09/03 13:35, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > When a Realm is requested, create a scratch Realm VM by setting bit 8
> 
> nit:
> KVM_VM_TYPE_ARM_REALM is no longer defined as 1 << 8, so shouldn't this
> be updated as well?

This changes often - I'll look into it.

> 
> > of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
> > for the guest PA size.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
