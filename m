Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608BC2BE057
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728806; cv=none; b=cBT+olaZmhAEdnfwMj+yegfGE8EWcmvgo1AGXkG8MBdE08UPmfbORiXnuLNoFytI28jNkRNS9AQgYD481gfu8xEiNkfNJLB3r1L28/+/xnhVxlYpPxS11mrrWaVB42Lz7ZcBwYnTu7BOagcAvWvzBEb7g6FtqSdu9QNhOBcQKt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728806; c=relaxed/simple;
	bh=b3RXsthHfuRSJYdglnYqRNEy70rxz4qqHOOmXyETQjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVLB+6jH7DjqX8066RvBiQiFjb+tWyUDnwPBJXu71qAdyR75sp2zT6s46f4xL4JVjn1I1m6m6pMX8YnYIoxFW6tmPqWiGoQQ+BIAqjUwf0MP6sdccezKQTABVmaetJJb4wViuwX8LUQGeSYLcs0il7yTcYh3rcV7hvDQZRL1Pns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KR9Paxp7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KR9Paxp7"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848743155bcso1034575b3a.0
        for <kvm@vger.kernel.org>; Sun, 02 Aug 2026 20:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785728805; x=1786333605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3SoMb2EehoxmO1SC5KL3bzZVbyyexo7yosgxBK0EG6U=;
        b=KR9Paxp74GDvEreT3F5VLYSUbU7XmXdtGmbQ+i9IZ0znX18/Wq/PJQnI1fBCODPiP8
         9/rot0SQHX6xXTtN3Nh5Txw7dhTF/Ff6swJw3LZmQWKYdFufY5CFL5cJvqMG2ILPVpE1
         OtDIATGTNul2UayFj3aDCi+KgCOJqT7/ydLuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785728805; x=1786333605;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SoMb2EehoxmO1SC5KL3bzZVbyyexo7yosgxBK0EG6U=;
        b=Hsq5OeEbTu5KHH2l4IgYiqkSAw9KAjrenrws5/3tgW/EgfYR4cxMzT53Y4BBhL+HTn
         h2eJ23V/HzuWAemKgPujMQLKovzvgBYZiayRbjKsp5cm38PbVZz2oW6tJ3DmSgy67XpT
         mDlM/OTDoHfVpDi0wHCRWrcsUd2qoSaIf0MwfnP7Q49HuAR8AHRA4WeeHFVMEGiov5LM
         6hzQldaJ8TdUCE6xf2xyCJ/Sbv0vI19ISpNpAk+KsupV+mjudUNIOdK8qI8+FeCoIU6Y
         DbkoHdNhjdAyPwtviqRTcrVxTcDhPZzIfybiIrqCAQRNbElW2qXlg3uezl6AkWEmZ3Nx
         N82A==
X-Gm-Message-State: AOJu0YyXpqEEL0KJBDiP0mOKuPp3L1dc21HwIknTddhiyHBiYNQlHoSe
	6GK5Ym86I6kDrOisZmvzqSKoqsuDZPmNDtwMEhTamkpZROOkkyxmUlGHQiMI4yCZeA==
X-Gm-Gg: AR+sD12uFU0Wj7PywACAxastf+jl49JykaUdqT5dy13mV1v9i6P6MU5oC2BwYCudMtC
	07SjLr4MaTWZb21jF0stnAg3vAmSNSqqTEFYgoxjK8Up18a5XFjzqc0qkMTGZohfMdhzuFG6pS4
	Ko/npAVA4omboUTtH6C1lTu8KcPMWSNGU2ikjEZWpswihHt6frqOyBk3dyEA/WmSHiHgoQXfnhx
	kvdGCI1XhiNVrKHog8ep3SEXlFmPpZ+72K1CMm+ZLA83twvGaMMk/px2U6kXIZR2Ks7hlR4iq4B
	tRyjVh38gWk5MVSkd3HhLdPxxD7bjQt+5ZTaZyLn0CiNI08QemdKb1/dPKVew7Vypc3TTg8af4Y
	PnXZLbdVAis2y65rx11kxOUOG3I8SpWnsYcMCjQ1bszZ1IFwj3MmA5r/56jG8wlOPKj2sIOlUKz
	vrV7lLLonYuhSi7hlltOOwHCeQeW+FVxnbDzptFaaDH50cexmW81JC4149txfJcCOMFDI/AhFWu
	w2TpCJjDXkY2o5S/ARtVVjPBoyVxdbMT3VS22Y=
X-Received: by 2002:a05:6a00:8018:b0:842:6004:3fd5 with SMTP id d2e1a72fcca58-84ee48236b6mr6709205b3a.25.1785728804652;
        Sun, 02 Aug 2026 20:46:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:a2b9:dfb1:c4ed:ad5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbd31585sm3056227b3a.3.2026.08.02.20.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:46:44 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:46:40 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related
 issues
Message-ID: <anAOuAl2pMfRnE0M@google.com>
References: <amG2CyrA-yEUmHqV@google.com>
 <CABgObfaKqT0gMUB_XRP5DW5HmpgaoTgmD-A8_zQVG2Vp5xZE4g@mail.gmail.com>
 <amLPUt59eFu1n25z@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amLPUt59eFu1n25z@google.com>

On (26/07/24 11:53), Sergey Senozhatsky wrote:
> > It had a regression and while there was a suggestion about how to fix
> > it, nobody had time to verify it.
> > (https://lore.kernel.org/kvm/20260630223723.83727-1-zcgao@amazon.com/)
> 
> I guess I can try helping with that.  Will require some time and
> help tho.

Folks, sorry, I don't think I'll be able to help with this.
For the time being, we use a different approach in 5.10.y
and 5.15.y.
