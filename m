Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800312;
	b=lku9VaB+4FONGQrWYr58l9Ir0vbOukhyY9QY6wSQNsBm+hzcxNAM2Zjq64ifII9vCrnK
	 3sJE7Tmk0Ih5uanQPm90f2rJo4en/KbcpWdlTyCYvyvj/AX25XkpHsEhsYj5LCfyHDVjc
	 lQejXNDDbfPXuYqlTUWS5x1DQETF/CbX0r4kHMQjJz3u/859XsHpx+24O7Zayvtj6igzs
	 np5vz0pH/a/kpigSXN4+krpxgHiJUoJqhnQAzQ5AEoMhoCOBxUlbFr4pIJbey8xNeiW3X
	 7QarMztvrmssoXKkwxz1AgADV1ndt94t+imxbNSEY4H86hCNGPiyDBtKQ0fcGDNA2aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=3qXd2J6ruDj64+tTvzJ5l8a1BpkEahRstfryC9kx0c8=;
	b=l+0OVWWPKl8s+sZ6QyWDhNh+z1yQytkA12+qJrSotSpqwphq5y6HU7IDQ4hCBkUKkADu
	 QWgpAFbmT7B2WQjP0L9ci0B0yq5cNREETNXdvOm3owvg3eo889Ls5P2EKV5dO3+PO9X7O
	 G23f94uX/dqVb2ziVE6dy1bMbigqRAKFyQnxZxTKaxgIr+mNBh+Ut8ppJv0U9PBUxu2Ar
	 1L3Nii0WnMDSKfa0jtuHLIlmiBt9s4OMqJheh6BKtPUYorSYXaBt01w9+qbWMNWrAtRiI
	 mywg+Zm/50s/4TbiPhBGnyKxebrAcswmUIdXUtHlBW0prZlZflfRtVv4ve6owkq7dSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GW0gPUbJ;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BBA606A31B
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 13:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1BBA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GW0gPUbJ
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso4838295e9.2
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 05:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793800310; x=1794405110; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3qXd2J6ruDj64+tTvzJ5l8a1BpkEahRstfryC9kx0c8=;
        b=GW0gPUbJdBWtzacZDmt3yzOFMVpKdCvEqnsg5EslFYN3K5Bagv2G+XSysN2sZ7eN1E
         VimCGtrtfA65HH2WXaDe9YqISUfpZ/n0wtR+PJfiZ0Z2yAio+BenOwDi+HLEXskSu764
         Mn5utyuZbBl2an3IxXfvhVU8mx0oJCK6/sZBRckISbPViM5lB11dKNY2J0YC2SP8yW2o
         hl28wE/gJtKImeOLXaEWQTDgedqEW44eusPfKF7Unv4wPKWxg9GDFJBCVwb9Zu8DtCio
         Y6r3IHrLyZF6AgXDnu09UeagorhUUskJnvaqSZrwBG/81SHLXrA3swJ9kOo/lxVb+dab
         CRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793800310; x=1794405110;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3qXd2J6ruDj64+tTvzJ5l8a1BpkEahRstfryC9kx0c8=;
        b=ezg0X37JqznPBP+P25jb2OHZPCl6jj5E3EpGcQRGV/SsxiS09M1+eK5i7/kL9Fc2jT
         ffoJTN7qMvF4aq7LFVokPBNRcJoEehCoNHinhlZhpIH5MiiHDYjPCKrpeIcQ4MZeUw3n
         qCz+M5n3cvvGJy9e5cOvZpUpFiqggQmu8RexR0vXd92+OYCBWfcqD6z+w9FZ0AylloAf
         V8PpI2O/VRsHVXzp+8KNlkBdqYXO5UrMjKWPHAMh4tg0vXZc+mrAqMfg3p1sF6v8xDME
         faWEevgF9h1W8ZmrWmcK0heiRiOUtz58NzJ8QQUmBI1ebA/b9Io+v+6eSINxI2ZyLx5k
         HEbg==
X-Forwarded-Encrypted: i=1; AKwUvBwbyJaAMSsHVwFRuexqxg+LMqHzGNFR4prCXICj5x+/zffsNkC30Um6JIy/Xg56Y7rKfjc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XeoUlvgoSgJ3kkiRPh31Kyfyj4tsYjLA7LdgYJYjxjWlB5fpJ
	SemKYlKObejDsZMfe9AkfapvB1Opb/ErTBWjbcczhBlATnvBayGfIZQX
X-Gm-Gg: AYBFou3dCAst/HE3jHWfnTrGRkizhUhMqmH/hohwvfbKD7DsnHqS8h+DLAyMcl7pOrk
	D0t3vnDT1gL7ORtfmTkTIizr5k2v73y9KSSWp+dy20AbfuUgRkS25PVd4AC4uTw/17VH2D4uRFf
	DfK8iUkb/Zhtp0XPdcISFCDhBMnrPikAVblsXy9ZMHZbynWgFn/P9duf7+L/s0rHCK8cSWqk7w/
	MmX5BjlXI/WL0VGhNG9X/lbRE7ZxuIoWeUmYVH7T7GRVPkWpxJ8zm1nDRQ8U2aozSgTCHmZaWAN
	2pUGzM1PSk8nT7a9Al+aNCcalzy+0pQkJOJMtztjh3HEoDbREr8eVCibYRgPfPAxEZAUecwY+0/
	UaTOEQFUKXKtRDA4dkAccBdBNYdcwgOAQecXDhKsgCtAmAPsf+YxZnyOpgEFIICz+Nj814PZMcB
	2D9F6IMHiQxE0tCtrWGSkIa2edZflldQv13FDCZs//2pQzImFNXsdqLNbx0C0cRN8S0ShCgchD8
	AeUo2/DyDtLGtKJgaZYhP2teMlLttkwbIDNeKGjT6g+ffjTGgOBCdG4oDOeFwu1SfBfw31z6mn0
	U/Wxhl2M/bFLrmDF/7eUtJJ2bGZ/2qch
X-Received: by 2002:a05:600c:1f93:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4ac180f2fd3mr386668395e9.30.1793800309884;
        Wed, 04 Nov 2026 05:51:49 -0800 (PST)
Received: from [10.245.245.237] ([134.191.227.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43cb234a1sm61855745e9.9.2026.11.04.05.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:51:49 -0800 (PST)
Message-ID: <f4f34bc3dd22c0e47b5ee764b1a4db8940cbbbec.camel@gmail.com>
Subject: TDX migration model
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Peter Xu <peterx@redhat.com>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>, Paolo Bonzini	
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Tom
 Lendacky	 <thomas.lendacky@amd.com>, =?ISO-8859-1?Q?J=F6rg_R=F6del?=
 <joro@8bytes.org>,  Kishen Maloor <kishen.maloor@intel.com>,
 kvm@vger.kernel.org, David.Kaplan@amd.com, Mathias.Brossard@arm.com, 
 "Serge Hallyn (AMD)"	 <sergeh@kernel.org>
Date: Wed, 04 Nov 2026 15:51:45 +0200
In-Reply-To: <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
	 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
	 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
	 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Peter, community,

Here is the TDX migration model doc that I mentioned in the CoCo migration
uAPI thread:

https://github.com/dedekind/dedekind-share/blob/master/2026/tdx-live-migrat=
ion.md

The doc focuses on TDX only. It does not cover CoCo in general or
Linux/KVM.=C2=A0

The goal is to lay out what the TDX module offers in terms of ABI and
migration flow today. Hopefully it is easier to read than the TDX specs,
which are much more detailed. Feedback is very welcome.

The uAPIs that we suggested were modeled around this flow and ABI. But
we kept general CoCo VMs in mind as much as we could.

The TDX live migration PoC implementation that we mentioned earlier follows
the flows and uses the ABIs described in the doc.

Thanks!

P.S. From the ARM talk and hallway conversations at Plumbers, I understood
that the ARM live migration flow is very similar to TDX. For SNP guests, we
have not heard enough yet.

Thanks,
Artem.
