Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F793BB13A
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790136576; cv=pass; b=Bgre+naRvQHVHE2SNmU/pvKoWThPYiy6rR0ryFctsLNojaHW7NTRAAnyALuHw/5F9EyIdtMkXcXiN3WR16yQM+FOSSW4S8l/f+y/uwrkCdBHSZKrI+JOpVPu3Wm3m/kNrytXuWDNYMblrXafRP9r9zP2Ii58Td8dv71DiA/h2P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790136576; c=relaxed/simple;
	bh=Dnc/j7Zk+6LJnBIRceh/xdncZrW4lrmXZNL4bSAVeLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMDWNVkWks5+WFu474wwNa6H/ffDxC4VXqOuIZ/fUlC9tFZ7Wc70YzCteNKDKLweayShd/Cg0WSEeyxGJ5OH3VCvlOVI0OQE6cLywAJwbkRg5WVutwylkjNPT5OI2p0bsFxR4AEsmBHUmy7pQhmvT04djdYruFTcG0FT0KVpTR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkFnOt6y; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkFnOt6y"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-530e8c6fb80so90491cf.1
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 21:09:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790136573; cv=none;
        d=google.com; s=arc-20260327;
        b=cMMDEDZfYwd7ECp8Q32nnqlE6y11LWcXMBbRmColwEEEpGO3+SiItQkfsca6ozMSVf
         yqC4x7MTIxfHNMshR/Z8ayJE7XTM5eMDViZPNqXYy6g6ZiIHXoEDCLmlDRsCtxJu8e99
         Xv/zS6Gl6fYKPhMz8M/4rypYodzCNfi3/jYPRUwrT5Dwu3mkqQW2R3RHS0HcrJwZY2cx
         S2TXVscn4Qhf4wZlF9vfdE3cNmuZ9lLg0VIUYKAoG5b1855wZAQt5Eiq0U+ubxvB/GlD
         9EbKvqSyiHejxKXjw5fuJ5YRaEPqdzKfT8mD9fsfZUgAjho0VDWDuzzE9mZS8VTbaxoI
         eptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dnc/j7Zk+6LJnBIRceh/xdncZrW4lrmXZNL4bSAVeLw=;
        fh=a2DzK+dSUE11MaSo80iiM1ilixw3zYZvpUOJsVt/pVw=;
        b=alJvd+PxFkiiY++ScRhUgyhrivQJ45AIgb2MbcquYRV4cT4W/B2sLojCMPvyudQaGn
         0DLWyvU43y4MevFMEYenYECFdmMa5k5uMyZG6wq84608/MdCtJp8mxFueNDi9Y2B/dt9
         pwdyvC5TIbiyByV2fDybqOfYZhlxNrlY6tzGP8A3Rwfncbx2hh30UXTGPlslI0zNsmYD
         M1cNwjJ/G+q1UHitenypTly4NvSA85DlhE5YnLGZbnrGP5vyKUhgBvJ0zuaY1JF1cJv7
         6f8zMelqUcJ5qW9HQLF5Kcmx14I9zncZk+7bM5KHPd2elyehbcZP3TMm8OmaqRQucViJ
         t/jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790136573; x=1790741373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dnc/j7Zk+6LJnBIRceh/xdncZrW4lrmXZNL4bSAVeLw=;
        b=rkFnOt6yzFxcZGOk9D1aBJBpyVv2bHOdFW4FtoqJXnrnCucLF0i5abuKAw6kEzQSNH
         qPVtUNXEDPGTdMoVHrmMzqi5CmBMa/+NFafv9pST5AmfL+5eSX40V8ghvaGnPYNOdqmA
         6H1estmV1kSkCqD6oQesIyoSYF6FbJJbNWQsvcg0McU9p48/OpWZBVW1IH/N+KT0fNmO
         iWY6OhDr2OYqjMbFr53i5Nngq9zSNvC+EMYNSkT95lsiMZe1Op/VITC7P4a2+JzicTTJ
         aKP8h1gpgwMyaIq3Lxdgw1M1aVoEoEwPld+tL6nBz4mpFgV2aJi/VNHyQiSlxN7S9CIe
         59VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790136573; x=1790741373;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dnc/j7Zk+6LJnBIRceh/xdncZrW4lrmXZNL4bSAVeLw=;
        b=ofuC85Ax33qFkppaAyJfN/cMf+tspUPjdiVWIlrBaWJCVVFDG6cJ1hLAvI4ZdOXEeg
         feTyZrgomJrr+Ca13jS9BE6VDAlq7JlKgPY/kCmH0D1gQpqsHfcOzaIsa9a1vdIhPRH9
         6gO61rtJ3Wp5w5Eui/c/htB63OehcY6keWBU+LqxS5sIUYBC6l6PkE1tLnMjjo0BI90p
         PFLWsu/OSn+rFj0S98YTBDr6ex7a3y+BQThkT+kyVq9ae/A04nrmi1HQhf//vd5Smz0K
         QN65EdNAiN3L0qmEyv/o2oFR/wOr5solSZbStA16MPwCna7glX7H+/tQE0ocIBnjtaYI
         ZAdw==
X-Forwarded-Encrypted: i=1; AKwUvByS999q+0ZBgJL2OXSYuQlQQ1yxaDTiY1NnDbUaCxko7+LSYAqNiW/s9oZZDw1nSoz13aQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nXvF5HpzfXGxAYCnMOBk8hLeSNnoIpH1J1lob2PN3adRnl8Ep4
	fcbVLi+j7J6MM5YeBJiJihZiT/KWGpu4ewR9w2dBvivPrxAq9wb2ZWNcX62NVDqsWwg4Xd758SV
	qZJKNnaw04OT3/03X65RqLBZOGRWy3BLL1pQoAIKl
X-Gm-Gg: AYBFou3qcpzjvC/HsyhmIZAuCIhLq65CW9Mu2eLDSFm6nuiJeQZvuDCVf7D2CXYyu+R
	WA4p3VAE1+NIW4OMAqmzhVHlehL0ekIHr/npyYREP0MLxI/NCQVFs1mtuwHhR+G1BuYBznQ1Dx8
	dT0qCuh9zDyWtPUBbLb5KXn6AlX8ZRnSLOqERAX7ZtgsnyR6fobTOg0tNKu3GRv3ODfy8+kjtMp
	LN/6FzCM4ig1LfuSPLEfPPs9P4Cjq33x9wUFC4QhZALDRSF9ATnuLb1j6nT/dvxc+63T4EqQtWT
	nNNuHu3CJbQE2QsytYBUx9EBXNiCW0hYQA6DLhIhzRrKlr5dJEe4y3xDbbRKPW8vZpcZQYy4kW+
	Sn9zbt2l/XyIRE1irwnyVdCY=
X-Received: by 2002:a05:622a:e08d:20b0:532:eff9:ca08 with SMTP id
 d75a77b69052e-532eff9cd9bmr2845121cf.12.1790136572782; Tue, 22 Sep 2026
 21:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <28f7a805c57da35d86b5c495cdf2b613a61d235e.camel@intel.com>
 <aqvtG90zWq6SkU8L@google.com> <3f97caf660cbe460b8bbaf3f2a72e4b6a3ea83d9.camel@intel.com>
 <aqxGN2Zc8sOl2RKx@google.com> <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
 <aqyAED5ZK48eEZtq@google.com> <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
 <aq048KmPN5WPQ4sQ@google.com> <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
 <aq2t5wJGLtsltMza@google.com> <arG3KvaVqWCDAyM9@intel.com> <12541025-6579-4baf-911d-dcf1453b3e27@intel.com>
In-Reply-To: <12541025-6579-4baf-911d-dcf1453b3e27@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 22 Sep 2026 21:09:21 -0700
X-Gm-Features: AclHuK90Qg4oApuVKiBr6JRMhyoUA6r8JsGe63F5O1WPce70Rzlk9aWR8H7sMdo
Message-ID: <CAGtprH8t2OAh59XeWGtBLUX4JXaJm_NDpPE1ZJeGTjppKWrSLA@mail.gmail.com>
Subject: Re: TDG quote analysis
To: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Fang <peter.fang@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Yilun Xu <yilun.xu@intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 4:06=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 9/21/26 16:00, Peter Fang wrote:
> >> is how to hide the fact that someone in the future might think followi=
ng AMD's
> >> lead and putting a precious resource into a tiny microprosser on a slo=
w bus is a
> >> fantastic idea.
> > As shocking as it sounds, there are actually cloud providers out there
> > that are wanting this, or at the very least wanting to see how it goes
> > in real deployment. I think memory side channel attacks are a real
> > concern for some of them. But yeah this is not great from a performance
> > perspective.
>
> I'll believe it when I see it (on this mailing list).
>
> If folks want complexity and low performance in the kernel for
> side-channel defense, then I'm your guy. I've made half a career out of
> it. All that I ask is that they come and ask for it in the open. Here,
> please.

Google is tracking use cases for deploying S3M-based attestation for
both TDX guest workloads and host workloads.

Based on my reading of the discussions so far, as long as guest VCPUs
are not blocked while quote signing occurs, we should be able to
devise a reasonable scheme to support S3M-based attestation for TDX
guest workloads without introducing "undue" complexity (I agree with
Sean's complaints on this front [1], [2]). Quote signing doesn't have
to be "fast" because it is not supposed to be a frequent operation in
the guest lifecycle, provided the guest can make forward progress
while quote signing occurs (similar to existing SGX based
attestation). Have we concluded that such a scheme is unachievable?

[1] https://lore.kernel.org/kvm/ak7PHTGEuxAZCvXw@google.com/
[2] https://lore.kernel.org/kvm/aq2t5wJGLtsltMza@google.com/
