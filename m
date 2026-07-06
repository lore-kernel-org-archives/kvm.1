Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA4E3DB99C
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368765; cv=pass; b=LBYgP8wnfNcBOSL+hJVoQcmXQXOQcyryIqrCCqn+eaEAyUbFmnOhZ81k2qno1C1lX0Np/RJX1V8AfrXZnVj+zV9J4UUJ/tnu5rhs0JnOdOXlMDFvSuHHUq7QWeFDXuInCQ02gBJYyclLoqGuGwsrJoIADNiSjsABIl5typS+ZW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368765; c=relaxed/simple;
	bh=tCsl8rppV+5IzTQq6lB9+xMxhNa330FxUZBTap5O0sU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4bTgjwkABwqBAneto2OQ7VgvIK4y1MjlJ2HzqfXNNC5ByjA6T/J7REKfuc9aIdqux2cwjl/MujZe/wcIOBrAhLSrpKD7+zQBiL6zta9hzpecl43u42c1kkqAI6iJRxKUrDq986st25cq8L+FGFMUCetGXdbpCiQg2FuBBS8om8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xpq1AdSY; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xpq1AdSY"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caced6038eso2880275ad.0
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 13:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783368764; cv=none;
        d=google.com; s=arc-20260327;
        b=k5mNJSX7do4HO9CS/AspKcgbKqaTXUSoY37Elt0LeS6rz2GdUllG5iNMTv52Eq1ecP
         w/kbBPAt4quet8JKz5736Q2yamQu+H++4w4uBBddR54v+TVHkQ5ZKml+C3c4Qhnudujz
         C+PD7VTTW1cht2Mbw9VlDEGtlHzWPTrF9Uiylie3DfoWJ9LdK2g5INrtjXqb9Lj/Qn6J
         B8I2NCkHflvSaS89L3/XLIotciNPrV/ABxvhTiPQNgxHKwony7WD9G4O+ohmIyWOqwIf
         VTfQTNfNruFjcq6ZXKSucDPx+mDVEO0kXP2BV/J2dokM/Fy/RnLeOcTTdBEydP6z6s78
         J2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=tLsQwaAXDJNDfqHeYJY0yk7pXv8pT0EExTJ4qxzGluc=;
        fh=VXJrcir+n/1o9lGkB2udcosnkYKbWrgtVN8elp+SDU0=;
        b=SLVNpKiIlMIv66nvpDzP2PSxJl3ZSTHMjMVQg3mf4Vab3ABh1LgavTjqnxGIA3+ny+
         3d7L0i/a/3L3G/fcIspFGt/kfgEG999kxoSoZJCeo22c/M1y92KmRBXZ0wQi56HbnkG+
         ChUaEKrZUI0xq3bs6jvNF0aCIuryErJewRI7p69uPFQblUGElcNnF+vxP2cESJyNC07y
         PzX8370El92d3hLd+GHXQDD/T9xK7bwh0U5odqjHgFctBfP5Dko6GZnEhP3DJ0gj0rxy
         AYvOkB+95Ln63BSk59nVIV+ZX7X1j3/Pf8VnrXu99qhTfT73Orlaye0kHvUEtR4wLRYt
         AClQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783368764; x=1783973564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tLsQwaAXDJNDfqHeYJY0yk7pXv8pT0EExTJ4qxzGluc=;
        b=Xpq1AdSYaXtDkyuxK4DG8sO9At7N6K4VUGtojwRbXsu/TMusqo3bYFcy2n7lI1mxfp
         JA/usplyzRzkiekYBEhY1GJBDWUXXVYr2vut/N49Zrh6FeSOfe8GX8xApZXUl0eQP0F+
         0u20sOpwoE5dQGJYG0ywB6UwW74NcqZnScgsaCscZ4f8XKVPuIMDVxYAMfkAe8YusWGx
         I+gBpWyu0rzTC1jTMsXNBY6+22W5EIDO0N3Ry9WUlBFhrU33hbA5n4P+HGDl5ashuGaB
         t9NmJ8UavsFAa8mmkCFOkHoxjbhHkcqsKDffnxsCon23B621ZGeMKq7qjCa0kHOEITHw
         ficw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783368764; x=1783973564;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLsQwaAXDJNDfqHeYJY0yk7pXv8pT0EExTJ4qxzGluc=;
        b=mJv5WF54NeqIYVg7lfpurGAxtyz6iGSCxW4m3Ey/IVdagvNTOqk0eUu51xzRpPpAu1
         Oe7uaHJuJ/a7EKo9ayNpuPlJgsnEsk0jZHO4AZil0MsMYZbfQVn+QeL3SzHLHgjwYCAv
         z8PX1lKfTPt+63dkJtgENEloBDlbAGHY7cCNfUgdtXRZVgFoeWhruZcCYj1ssQ3NNbpY
         3a+4H4GnZHBYgmw5p9iMhKpIayc6ywSYaNcbVnc/L7PpTrQzps/Ou+DQA4YEb7P+bWT5
         6KArjILGtSwKoSF0cKam3UYpbtzQq4N6cOoyDkkfaI1KX0czbgGFkdWrl6JAdG8uoDp7
         0wqg==
X-Forwarded-Encrypted: i=1; AHgh+Rogzu/UEH6oX8GBeQd/0ClYCjLukqPMwe0MFCQokblXCk4qX1pLLHaxtle37Xm7ya3lceY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6pDPBGRISvURkJ6vhph6PSv6nNiMUcxVbcYO+1/vW6kk97fk1
	RHynyVicINjg2M5lzMvplGmt8HuVXj6r18x4ZuStJPy3306qSSF7/UfaDqgjnZNde1vPJtXWxV6
	QhUCxIrsT6x8iNhOVXaHtVqNU9s4njfVwhvN3oAd/
X-Gm-Gg: AfdE7clBxLY9jxg6MMlzQHhA1L+tsKTObJ7lWHqXAXud5cd3jgk1PNEaIzfPAMwnuu4
	3YiwcBqjn1E85lUn0U68qaWBga9lBaHOnBwFhFd9u8NC8ahevar6AeT4sJKIhPfdw9XqaxYauiy
	7x4dLRrD7HKvDe7YZPGXjB7DIoK7/6UqLKK6aRDlhlRG5GsURLKy6vaEXL0MEUJyRDh84eVhr7v
	UnYYYtmLmlCWqFKCUOiiBEH/O9/yQVVgXxXv/hFYSOqovtb1LxE1AtVZkEM7TmboWMkfsCMvtXV
	x4ddzAwyLTpJWTDWmcxFcVqEBCs/CWAXJQoV5bura1UrgczD/YZyoCLlDoE=
X-Received: by 2002:a17:903:1b2f:b0:2c9:4163:269a with SMTP id
 d9443c01a7336-2cacb070123mr173926025ad.18.1783368763186; Mon, 06 Jul 2026
 13:12:43 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 13:12:42 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 13:12:42 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-17-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-17-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Jul 2026 13:12:42 -0700
X-Gm-Features: AVVi8CfMMieKOJ9KWV16RQIgCbb5IZwWCmKGZX-xsr03tKGnv5YmqnGOv8ZZx8M
Message-ID: <CAEvNRgGN=DPP27uMFCmaJu9pAdv4vj=XaG=ofhf1LfiwPZnoGQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/31] coco/tdx-host: Support Link TSM for TDX host
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

>
> [...snip...]
>
> +static struct pci_tsm_ops tdx_tsm_link_ops = {
> +	.probe = tdx_tsm_link_probe,
> +	.remove = tdx_tsm_link_remove,
> +	.connect = tdx_tsm_link_connect,

Since .connect is called from pci_tsm_connect(), which is in turn called
from connect_store, is the plan that the VMM should write to

  /sys/bus/pci/devices/.../tsm/connect

to set up SPDM and IDE before starting the guest?

> +	.disconnect = tdx_tsm_link_disconnect,
> +};
> +
>
> [...snip...]
>
