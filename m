Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E173FD15C
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777544933; cv=pass; b=mIgtu+fykdj2gFSFs6Pc2iQnyOCYB7NL9aFXJRdONW04+8lM0ymRKcZ3OhRtBGNviwyoTUv2b5WustL+arSPOEbDMYqj2Qv8LlmPaJsL4VgSNnonQfstl0mg6GS5JLhCluIUZh1KJgLyF4Q0JwQ9ieQAvHYPEReDGfufDezlQR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777544933; c=relaxed/simple;
	bh=eEJ7BdBaqjtsp+3J1ugO/2gvRiC9shqG3RVtGL1oo48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnONGYTh9eBxROHYveetJNs0oo176dIVXZnUCcLnh3y12XiEXAVT7t3Txn5Whj3zcwe9Mk5mvcQ1yPAM468xJq0QPmaQJ1k58qOaePNZQj+nt5YgCOlqItPri8chH5fvlj8yXf3pGtS4Np7wBqt5tePI92bA6H8+xn3KbFKPZuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtbXc8v5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBQpp5Fm; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtbXc8v5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBQpp5Fm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777544930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hfNnEkEZRS1o/FMnT/LuO2alVr0SQboISR1fTH/yvk=;
	b=HtbXc8v53Abtu4/YnVnwhVWnbrC8b/EXYflGb6AqW90VOmAn5u5cWgVfDVScBElulwjFp+
	Ip1prmgXGR714bESSV8q7itrKtGX1vZu9OSjJkIVbdqDJt2P4wAKstMWybcjQqHmWDVPHf
	kv7vuboBtiSQxx4jLALtUPJlacFvDbg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-4a_7KtC6MDS9pMbdgbe9bg-1; Thu, 30 Apr 2026 06:28:48 -0400
X-MC-Unique: 4a_7KtC6MDS9pMbdgbe9bg-1
X-Mimecast-MFC-AGG-ID: 4a_7KtC6MDS9pMbdgbe9bg_1777544927
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43ea7a5da42so356539f8f.1
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 03:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777544927; cv=none;
        d=google.com; s=arc-20240605;
        b=LczzvU6XWq1z9p4q/uStTq0DV2dBJQGbq7mfXQ34frrw3yeqIpbryUZ8HTRBAOtKjj
         urZ3Hi+GWH5k3xIXgjHed1LXYx8ZqqOxD78vuYd/EIckTGA5ETX9Kqw1Kjs/6Uc1ikwV
         9rDob4PSyfa7ukqglxe7Mr6wEOuLYvqdk0jLKuU2Mmb3W3vmpHg5qmyBqsvKGcOuK9vK
         3/K9YZlEsAAe+nuTfnAATsXlFH4dCPtTgjvQVdsIo3OTWy3N7V+awrh4y3S0wO4R+Bqv
         RFBJXSeVnl/C7AmRQXOm6VsWrzx466Ka88oUE9Te2JygFz4P7bNqUUWEK6/BqSm+shiF
         dKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3hfNnEkEZRS1o/FMnT/LuO2alVr0SQboISR1fTH/yvk=;
        fh=TqKtHBQPvir/S4piBQQO2yjlgGMHxXScXmxrVVw2++w=;
        b=GPpsYd74UzOutnoBuTChGbQF2sNQT6NUlmZmGP5mvuUQXiSThnJ+bEE/RKWo+cuE/q
         5/V4dYnaH0Sfn3sTg3VCWFsJ2dW5hITxC8Topk7lkt5m+sHtlIp5ew+aiPyC8/1Xdspq
         7ZH+Y/KAfC0XJfJoSf+ZasSfmDPdHSW4Iy8Ylc4sdOMWkJzmhRqpEyyjW/azlLyKeqiz
         ahqoQI64MNfVbh8AdtrtYfnB7f6Bs3ZoD/EkNFYMTLzfaOsCpBXytyEo3DCnukOe1vW+
         bplj/Z1M1b4c8TD+TueRqF2nyo64FYK3hYAdy7gEYVdyWu+XVv+TzbSmo4I3++W98NKQ
         hELw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777544927; x=1778149727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hfNnEkEZRS1o/FMnT/LuO2alVr0SQboISR1fTH/yvk=;
        b=LBQpp5FmB7lCY79MM7+qTcBSjZlI4l69zBvfrIeoeyJUq78Ap+T53t67eGdpn+6349
         w6ljndSwRVeMGCQOdJLZKnfGU5X0KMXSqpgI4cRGsqlIsusd3CQyIp9D7nlZlX61RhJO
         5ovjFKuh4nTZ+iqp9wHrsnKLdXEb/XNzLyBUZwl++AJOPyTT25PkX9XDilqH2lkNTMFn
         EoniWyfJ/OZT3HJU2CZHumm7QohhXMZUedEh4C7/kkFTIF3+ST38Y0FLBiD8igpeem3l
         Qr9Y9b3FsepQej8VF4XTFObxXiSl6Ye3AHXo5Bt1drpOSo8daqzpYpnhnFi5WXFcqcI6
         4f/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777544927; x=1778149727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3hfNnEkEZRS1o/FMnT/LuO2alVr0SQboISR1fTH/yvk=;
        b=fgdLdkGU76Cm3ALZBvd8uez3WEuc+vVZY3WvTZV/j1hs4r2rrRRVsVmvl0johFNWjV
         5g6I8H9OKWm5sigGpUUaphhqrXCvtU+HpmDZEQMGiaF/9SnteMAQP4djos/f8HCQ79ay
         /0Oy8mm8MoJboXN2CUdMaDKsCr+eDSuf8/zUx39sQNJeF56NMhO6miaAycahlKX72U3j
         iYOd34I8dVHMcVCQO5HeVwwEQVKBVTfXDNnLIH3obeM7dH+mbKdt2oKRF62M/+kb2lDi
         jCr0YVvfRD/QNb1bLRLbChLbwg8fD9gGVCE3o2I3Ij+JIavr1oUX+Oeq+0GnLe5Wcv6H
         yY5g==
X-Forwarded-Encrypted: i=1; AFNElJ/kejTiEn4lLNu47YcTzO0xtAtFdOb85pDGB6E3do1/iUDk8wf/NzerorHoaoVerQUzaqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxujnTZKhnfnVtOFHHiyy2LA+GeET475MhRTn4AIerFF8Tekk3t
	37LxG53Q0C66UhgDLKBJdtlnnqdLOAgQgdSMDviqpoXXIqIfsST1okXwHzqrBU6IEB3pyGoSV/R
	1H+gVp1riWCUdtFm38zAkvFbKNinTUth3Yzna+3sj8XkKsm+JSAraKj3ct3n2YP57uK0S4Ar6Rv
	Du+89UWPLf7LZJpN8lH24g482htR1V
X-Gm-Gg: AeBDiev183TEzONN41y7G8eBAwYX5mJC8FPhPVJMVdCt5vCTuo0Oj60pE3hbUSRm1Nj
	tG8rmRPvb4pjxQibDl3nzRo7PdOE2lNbH5PJI3h7PttBPIwHHsyNA+Rrw41H/CROu3e6y2Iq2Yl
	zIynvIuMfgOCy/rVxwnzvm4dMfEbe1HgWtFvEq2A5SUKTdJieNWe+K/NPpfxW7LmVLs/oYbwF35
	qqROb8zDdalmap0nIb9xBAgOMD2kIe3h/45RzCGUcq/X624ZtoywH+B9KtaWBlEG4lswtsI2YB9
	MkaemziPQm95p2I=
X-Received: by 2002:a05:6000:248a:b0:439:ca9b:1f61 with SMTP id ffacd0b85a97d-4493dcd4b84mr3309328f8f.17.1777544926924;
        Thu, 30 Apr 2026 03:28:46 -0700 (PDT)
X-Received: by 2002:a05:6000:248a:b0:439:ca9b:1f61 with SMTP id
 ffacd0b85a97d-4493dcd4b84mr3309300f8f.17.1777544926616; Thu, 30 Apr 2026
 03:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110946.11466-1-pbonzini@redhat.com> <dbc9f517-bd57-4c1c-a638-c33bb83a1171@proxmox.com>
In-Reply-To: <dbc9f517-bd57-4c1c-a638-c33bb83a1171@proxmox.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 30 Apr 2026 12:28:34 +0200
X-Gm-Features: AVHnY4LmZQNglA-x7f9QZRtKTwdmLjpVnuDslXy6vqVIEy_tDwLpt1S47iBJ1IQ
Message-ID: <CABgObfaFeK4kJpMGuki2hQxnz2ij8Nyyk0egxEfW4b_OYf9hgg@mail.gmail.com>
Subject: Re: [PATCH v4 00/28] KVM: combined patchset for MBEC/GMET support
To: David Riley <d.riley@proxmox.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, jon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 3:05=E2=80=AFPM David Riley <d.riley@proxmox.com> w=
rote:
> I observed the following:
> The guest now never actually boots into Windows. It gets stuck before
> that and therefore does not even enter Windows Recovery.

Last minute rebase screwup. The old code had:

    vmcb02->control.misc_ctl =3D vmcb01->control.misc_ctl & SVM_MISC_ENABLE=
_NP;

New code has:

    vmcb02->control.misc_ctl =3D vmcb01->control.misc_ctl & SVM_MISC_ENABLE=
_NP;

And now needs to pass down GMET as well.

Paolo

