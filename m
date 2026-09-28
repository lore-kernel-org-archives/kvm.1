Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BF54E3242
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611034; cv=pass; b=VzlP3vLw18GDQICe6YdcL03YNxjLfKoRhe3+B1vtnD4IzBn5v/q5IO82IMfVo/0qBFghJMXJT6gabj6m1wRJckfxI6usjO9G5OAr4+HKF+LCfBF+W8VKVuDOHEoA06poz3KIXgbJApt6HW6PzCNuURJCLUiK9C1mgocFfZ0jmPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611034; c=relaxed/simple;
	bh=QqOHndixwXTfbKcazOrogEdBF1Lh5VPxTHmhor2BS+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aduSy3kiwo7//Ia8m7IiXZ2nCtKHKHTDxv2ITC5AXnJ/VCS8KnmioxAcYo+4gHZP4/OO2g6r/Ilw8sTKeIJ1C9c1ATTX9hRiK76QAPhZa4aVIWZyWJ/XWMUKpd/JvOht9iKjj8hk/lLxTkcD+10gCj1CWK8a6n7j5pqa47VK7ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cWeh1Vaz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FjeO9ox2; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWeh1Vaz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjeO9ox2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790611032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/ZTD2VeOCjUPPogrc+Mc/r0VX3g+O7Z3MtGT/sljKA=;
	b=cWeh1Vaz7q3eZnkqonoVOPF1YF/RVgC+7FcGRYlv0t5jT63KddeguL0DBpszp2rEC8iClu
	rmNVnzFy0CC1ytXmXAciWd1tFqtEDklO8kRB1RFiIu9TjSUxxkdwlJ6mzruOUOblqxc54B
	1e4lBux0rga3YEOD59YOegY73vs/mQY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-RL-zYlQ3OLCKKE740w7tig-1; Mon, 28 Sep 2026 11:57:10 -0400
X-MC-Unique: RL-zYlQ3OLCKKE740w7tig-1
X-Mimecast-MFC-AGG-ID: RL-zYlQ3OLCKKE740w7tig_1790611030
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso3537625a91.2
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 08:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790611030; cv=none;
        d=google.com; s=arc-20260327;
        b=AkKHdL7aZppWwlyLHGo/lhuXFa2pvt3nzaeYOqMiEP/ctrNQcTTyT8XcvyoO09KS05
         vVcV5evTQkt11fJGigYPapvfj719tEwo14jQtUhSlsqLrzioT8apexZFqm/D3mKZPhTs
         qMSt7By3t2nrjVRZ55vLD2yxWS9GZE0dUK3d9PfI6bVpkwYNt2RUDtTZbohEdsGfZxlg
         0Yo4BwIPi9OJWuTICDJXFRXmVvHzm8BNeK4dDV/uoXzINwYsdOGjWe7yxZ9Fa5D089vA
         zmJDllMiIgFRY2v4Tms3PX0wBadc3Ybk4FGX4vnJc7acSAOqLlLIKfrHutYvzRZCaWYs
         cAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0/ZTD2VeOCjUPPogrc+Mc/r0VX3g+O7Z3MtGT/sljKA=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=AoQ1uySb4EnNjryeqXNiTmiZV5ud0QGeGABIABSUZSWoRde4uzMAtAYojLLmLyQhq9
         AwhhQaFo7iR+MZQGozA20Xw4R8OrUcuYSYS3H9t0d2J6b1WkfOucwlHxQI7cnafmFRCp
         3Q+FPHGv6bj/U9LGQB3IlDPwNt0kHBojLb2SMYWDeeDHO02y0Z6MKISvypsLUiGCHDp/
         PI7EQ2XtRZ7GHjQxTt/GHZ76kOtasAHWuYlL/Fr1fpPri1sHE+Wbjv3gAretE6Y2AvEJ
         0iy7lD7ufJdFJQjxNjazKIFx06P+U/+8ro1h3XETzgQ0b6ZgXd+0VhLr7om2e5+w9eNL
         I9yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790611030; x=1791215830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0/ZTD2VeOCjUPPogrc+Mc/r0VX3g+O7Z3MtGT/sljKA=;
        b=FjeO9ox2H1n5hhCeNlVaE7A6A4aSQ85LY6/jLva50w4642KxT/NkxrW3UJAAkfvLbg
         LeqEhL2ufzQEWsjjXU/yhwK5aDM3ksxtc7NUSqZHSr1f17Yaj7GIMaAVeOkQqx8N5033
         O5NTUPr8/s1rwFn3TylEea9OQn5X1JdRxp4ConZ3RpJZo7T0o4iIY1Ujy09OZTXfdIkt
         a8K8zAm9ZUbe73YxHZJVptqxAkanhx56RVwRXa/KUj44h/ij5/ZjSpGgBpQOO0udHuXY
         LzD3TK1G7LpV3zEC3rQ2bAcMqVMt1diI2k0ycyolAvTVNMAVCeTAFU1LHLepzzentOnY
         crCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611030; x=1791215830;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0/ZTD2VeOCjUPPogrc+Mc/r0VX3g+O7Z3MtGT/sljKA=;
        b=Xgjv+0qpIXbRcf99hV+Y8fXjkFJtFkkkT20J2znmj91jDyWX8OTtUX5Wb/m7cGUwpF
         5wADhkQZ4H5uUwDrzpGghB8hRN8PqjDo9IEJ/4mIUdfLEz52SvMSggUTqQljg1hglhMb
         c3qQmvyNblNTXinUucPUp1nNkkSwlM5YLyDoRmo00ibuvqlTh+GCWP4G4na+XvKnOrFb
         Pd7Brgnl3nRGd8EHa1BBawY8Ay0YQf2OQeroZp7cCrrM972e1av7aJnsU2XPCRRdY9sY
         6nMTneMxKerNMXpTeTTZ/o0vPeQg2bC9tEBjNxk9jK7gi/zhOIoOzUx31jhapTSRGa7m
         TJwQ==
X-Gm-Message-State: AFq9FYIXdjNg8gPmBT1j3VB0POVCNDHuqc1RWsiQkMSAeFMz3SV71UDe
	RuIOKBblpiYtqAIzOnbXQ9Rtse/jPnOGsW5l6PLvOEqvtqmrjnjhAMqOklMC+mGfbNWnGU2HC1o
	lM0g/ozMIvvNIxVzwKTCoX2GWbk8zWxB9OzEKed6s+AjA+CeSC30dmw36nIu194HyxyVXuoOT55
	UhJ3XHZplbIG7PbIlj0x8lkxrQs2/z
X-Gm-Gg: AYBFou1JE+/ROwfBCXwGO9POwkuAzd9S+PqXGE33DG9LAsXk8dXFzs5A/9XAvG0LBkL
	AsN4kGsCfnhHpbCtw7PI+Pv/cU9nl5049ekI3kJngMpQMITWg0yq/Q7wNRqN2O8m9Ojp5iksE0A
	4K6R9QNc0vuBlrsj1g71miwMxRYvCzoHcZTTnMNx5KCuufRn8BkeSv5Rx5qCFhE4Ov3Wo+lrGH9
	hihetn9qEsGFF+sGx6M1+YTSqx86kGDrfr2E3NSYmOlbnSLyjhdWfVDxbsEMQ==
X-Received: by 2002:a17:90b:2e50:b0:39e:6a81:5a97 with SMTP id 98e67ed59e1d1-3a098e3e987mr11638007a91.43.1790611029640;
        Mon, 28 Sep 2026 08:57:09 -0700 (PDT)
X-Received: by 2002:a17:90b:2e50:b0:39e:6a81:5a97 with SMTP id
 98e67ed59e1d1-3a098e3e987mr11637997a91.43.1790611029099; Mon, 28 Sep 2026
 08:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925233321.2381319-1-seanjc@google.com> <CABgObfZeA_q_prxJhbdNqYpE8quPD360LhVBQv8ypcPpLA-Mhg@mail.gmail.com>
 <arqKrvYupBpAM2WI@google.com>
In-Reply-To: <arqKrvYupBpAM2WI@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 28 Sep 2026 17:56:55 +0200
X-Gm-Features: AclHuK-7CM2Is7844IC-ONgeUbRSTmzwlEMShQq7MFNhnttTE_XpGhhHS1k5ziQ
Message-ID: <CABgObfYBt61rn2RjSP2DQqNUN-eBK6NToW34va+1x=K-sQD4VA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: Fixes for 7.3-rcN
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:41=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> > Pulled, thanks. I added on top the SEV cache writeback patches which
> > are not present here.
>
> Heh, because they're buggy.  Sashiko pointed out flaws in both[1][2].

Ouch... I have just now noticed that Sashiko only replies to kvm@ and
not reply-to-all (including LKML), so depending on which duplicate an
email search took me to, I was or was not seeing its replies. Of
course for my patches I was specifically looking for those replies and
therefore not seeing the issue. Fixed now. :(

Paolo

