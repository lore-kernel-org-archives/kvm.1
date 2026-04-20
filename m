Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DEC388E60
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687888; cv=none; b=IpS307VBc0lqPLL0Cb/hnbKaYmPwPvODHjXEA+gB9oOOfapMg86TSLRw9obeRQkbYXqvNg6qLH6i9aSeLcqR43k4HTSMpOGohjCQEotLTlLOl86QKh9WgvATe7Gwt1WHFSnW7bjQMmz9DnQ8Hqs47Ebil/JXQTG5bcjQCM8ZDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687888; c=relaxed/simple;
	bh=Ch7JlFp085OS098b7/18gFzyAYM+A9X2+LIkHQ7YpIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUOyO21RQOZ/2sRECpIjdAdu4sAeyrr+U6WLZJFFxitN+VjYsNDLv9i3/CBEgN7vz+wPFHHafKqqOR1rWwaOsvffmK+Gv4ZvpFvS97lwPbZHUGP+KVPqtP4E638mQYmL15/iQX/NnK/IWlwA1E24ECD9/f7mZ+Xe+Wy7Ugc0k/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=T4praowv; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T4praowv"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8e895b9e7cbso262568885a.1
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776687885; x=1777292685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ch7JlFp085OS098b7/18gFzyAYM+A9X2+LIkHQ7YpIE=;
        b=T4praowvx//dA8hjJk9l6l/pZwl6yibxcOtmQqPPJcOKlLKGMIBUxn4QsdGpDrTXlm
         1arwMtkVht67P7ZWe76BQk3BlfNxt/sLeCIYQpPrRUzK97Xi3Z3Oj/sikeytDNozOHC+
         V0Qj6YLhOrRycPoOumYIfCzjoyGtzPCCdFs+LV3KS0vjFQWY9daqdf9yxUGUpSp7b+z5
         cV2ClG2RIApv3jZmaWDsda8z5LK1IDR4FDpKMoPEA5X/oNdUrIRsHqFrrEbzL5vv7FkI
         7bu5YzQWqevdb549KGgPeKWWIInnx03unyVqThoy5238l/MfXGlhxSXQOsvsf6INYOEP
         96mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776687885; x=1777292685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ch7JlFp085OS098b7/18gFzyAYM+A9X2+LIkHQ7YpIE=;
        b=miiGzk86BBDl+h6jm199cMnHUTadlwNlfCoZ6KHSt6+AZUOlGyrS3Ef5mntKqvp/K5
         YgwfarEJ6TFaeAeR8ltHWnW3hKcJ++bTDsM4Dmpm9h2GslU7l3qI2FGVwF6jTxoAw7Hh
         Mk9+QtvLWuTQGiZXsEN5muipbioYm3Z7Pv+fbRiMuGaojYeaXkHERlk+lhqJ3hT9HnJR
         HZDdZ1bbrl6qd3KqcXH/iobxiSOlDkFUvxwcPfX2LuSOPG1Jxm3j+N/4DeEB4azn+6Sz
         /iBf5PE84czJomPnXx3VEVpxoIWcvgzi7CEaFicSf6GfhBvVxr3qf9s4+cd3zxWh5+7o
         htRA==
X-Gm-Message-State: AOJu0YwE9y2EazSgPXH4rAZoc3VIujuskYjVt5W6Av9miIzdCufzcf8b
	MsKtJ3MR6xIPX91tY2/Y8QhQ7GqM4/Nd1LlvXkWlF6ZEoi1KRAXTtPzYbJmsKl0oSPs=
X-Gm-Gg: AeBDieuJluXHa7UBuoXsAcofiyF5copfaTi6nHvfR+0QdBmVD/YWFjcSKGOuh6MDDio
	LitJ/rfNgTq4pgULkG//YKgKhvJBYdwK4hx/TO6QW4ttK2fgjUR6twleQeh9wm13YXAxu2jIcFI
	o+VvlXX/vKnCWxIJKiO/hJLJ8oqfpV3Qwv/3sGRi5ldapVa+kAsDq1XbWa6ScyLgAr2Y811k8gA
	2vX4Oub5o46NCm7TKCxO+DVc56PMvSe0zyQkWRoaYyV4KkfZ72gu2pcKAGVgJ2SQW9myVw6rftF
	KOQwRPmkYt0Vly8sBD0lJJPP30Abtv2Laxv5NJCEJiBADe7Bvx/vuc2hFsu6n9ms4vEeFkNesfU
	t0eZ0SoES4tElLJGocKD0Othn0nsn8Ppp7HoPIeZmSRi9xaEaNiO8K2LdNrfxi1o1PBn/a980g1
	D1AQXm5ySH5Iqi8au3LQUjeGqU6e5u9QdwUW7HI5pKRvPBk+8WC5KzL86yODDyOlmYPdZ8U7ktS
	U6Wfm5i7m+JrI2s/MZmBVGKTLA=
X-Received: by 2002:a05:620a:440b:b0:8cb:3e7c:a4a4 with SMTP id af79cd13be357-8e79208250dmr1865255685a.46.1776687885418;
        Mon, 20 Apr 2026 05:24:45 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb9becc72dsm169155785a.34.2026.04.20.05.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:24:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wEngC-0000000CEWE-0Joa;
	Mon, 20 Apr 2026 09:24:44 -0300
Date: Mon, 20 Apr 2026 09:24:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nazar Mokrynskyi <nazar@mokrynskyi.com>
Cc: kvm@vger.kernel.org, alex.williamson@redhat.com,
	linux-pci@vger.kernel.org
Subject: Re: vfio/pci: Qualcomm PCIe WiFi devices drop link during FLR
 causing host AER crash
Message-ID: <20260420122444.GN2577880@ziepe.ca>
References: <70de9b8f-b7c7-481b-8cb1-931e3b82eb0e@mokrynskyi.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70de9b8f-b7c7-481b-8cb1-931e3b82eb0e@mokrynskyi.com>

On Sat, Apr 18, 2026 at 12:24:07AM +0300, Nazar Mokrynskyi wrote:
> Several Qualcomm PCIe WiFi devices drop their PCIe link as part of their
> internal reset sequence. Under bare metal this is transparent because the
> host root complex performs link retraining automatically. Under VFIO
> passthrough, the link-drop generates an uncorrectable AER error that
> escalates through the parent bridge to the host, crashing it.

If AER's crash the system then it is not compatible with VFIO, IMHO.

For VFIO to work as designed the platform must be able to safely
contain all the errors the PCI device can generate.

Jason
