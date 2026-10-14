Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20F34A6CE4
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017157; cv=pass; b=Hmw4gyqq6hu+bDPM3udD0BYi5up46sAHu1SExaqqZqCA7BQ8ES/3lqypdd0GiNmMmsm/QjoCrmIqLeDKP+GA9WC97dmg2CCdgBNgrFBCb8jtDPFDSyGZrMkgAYvgeRtdac+0GQgHzrVg4KOPNzJ/IgQUNBEdTTMOcEgo6H651gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017157; c=relaxed/simple;
	bh=4+84p/RrrdzZmA9eMDawKM5I6T2GTBD+KG/Q+hsl6kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQ3FK7NtkHlT0kkBHUhgG1tupSFxdujhxDAr7clZ11CmBosAUQmYV/FtViv9nU1eeTkrT4Yy5ucjIPylFmqYAuPH+m6HJpiBBz0u+lwS90FNKX5HQYFP78dJuuqK9lhLZZX0Nptaa2bwVKnnhShq7qJoHJ3hRPoEiOQ6NT6YWtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YO7Q3Q8y; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YO7Q3Q8y"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so608a12.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 15:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792017154; cv=none;
        d=google.com; s=arc-20260327;
        b=VQWJ9jcdiT5OW9SOewPrkdph8dQqaYoVeM89tAEmnQNCwAN5SgFqe/gWvyCMupC/3s
         BNgcHs5//KzzZgiD35bc+vajWhGDbmwPwyRaxgKD5MM+P17KkSVck/0bG7/rv6ON+xoL
         p+sAKlSiFngzP9Rnc8z1CIkZfyRIE0VfVlk264N5rnSYMzDpmoWnzN5rMdJmNQ2KnRCK
         sAEP8SVn8Fo1dDD2lMiEQKgwJXw+cUW5Q8FET7x95Gr1XyA28Imh4JY50/H4p0xPlbhA
         sNaZRHXMcxUS/7BnhRGghWKGcrz455J8xOZHRHDTzcPVgYJY9HZeRmTsN0eDG0M8Nude
         AP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4+84p/RrrdzZmA9eMDawKM5I6T2GTBD+KG/Q+hsl6kM=;
        fh=o22OyiWVNV05jFO/BZoY5zHT/GjDZDovqtPmuD8H8vo=;
        b=c9D55UljUmW5imutM+Kc5hO0H16CGumCyPJ7dfKDbinFjKZ/TMx2/8eNmVFkY463Cr
         LE2fUi3nn0LScZPUThD8sDBhCwRP6JpUN+Vg0VjtOxPHTgcb2TH9Dcn1oKv0yoCXY5Oa
         mZnCvHEYvkz0FZqK6LsoWgc4K8hqCxvVSS7LWyrTlNyqCIB/AU+OUBamqR7LmYM4EGLb
         4gdQg5y3zy7tJesQMhBmbjne/KRxRKZWpX4XVdR4ed4yG8MALOqY4JHdVkRxo+8cC83y
         7ajBeySHddws6P+ixatbImgGuK87J0fMOyUFnrGm5FMOc7xB5uQyaeTHB8DRsNZUKuhD
         pRgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792017154; x=1792621954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4+84p/RrrdzZmA9eMDawKM5I6T2GTBD+KG/Q+hsl6kM=;
        b=YO7Q3Q8ypaRb+MU4PObCrJGi3EfLi/wDAr+yhPepMXqp4hgVEysmioMT2R3N2ROyFg
         pJg6jPQK88gA0RH1Eiu+HbbRvDtmXhTG8Al3LIdqPOPCxFeVYjXSODySOhiv4XhLp3YV
         qcJMz/FWjJoT8o0I0KzONRNyNTXxUEGkRoLDROMqCAhW2oH9GpDmS7KulxhbfoLgIpIS
         HE983Z5K5vYliffvb+xW8WFV0KeEigkXeYTr+zFnyw+Z+580D2eUwxp2Yd621Xkq1ElK
         wVX/X4EY/umm8YQSucvCJuDmLJmZN63d5HGXlEJTHBLlp6uiLDiUd4WqaxuxBveHmzV9
         NEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792017154; x=1792621954;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4+84p/RrrdzZmA9eMDawKM5I6T2GTBD+KG/Q+hsl6kM=;
        b=z5SpzsjX71MdMaTWj3DfbxD2GzjfaRk8hAJwH6pYIjTZafh1x46lSEqNNBzmfWFUIv
         uAt15wBXTFV9HTbY6dQAeESpZj/YUEDwWGNwNpb68PZLGYD2Rszv8detbCT2pHKpDbcC
         XVNQDtXVlxm8mNQK8wWh/DkjP5+7yLsTFfDcBffXqB2MygDIZA+gdEthGkfkJ73fQkKp
         L0MQ3Y6AoRu+ZI9GwZ51E73PahaXH/dmdu81nxxZb1N6sHKNTAt8dfoHN7x7I4M0Wb/F
         4wu2wRR9751w+9OoteEnK2RSfwmv4vDZrY+TzfXFcwZxqZU3jEdg9+5tzADMyQUB/BS1
         442w==
X-Forwarded-Encrypted: i=1; AKwUvBz0b6wokqeS/gKdgmqoI+8QTZ2c4nn4szqbjpLx8nkrrTfVph5xu0i5uaFKiLxpX86sjJA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbBZVgUWGRYm0hGYENCW1Z/ASSw2pnJv7NSI/TAfKoZ7QzGSYJ
	vGtwdZKaYvQW+XBjBL7ax/nxqySgIOvari/6jGhNRBuLxR1F4ahb9KvzgjfiW5cKH1ctUfogSKD
	yng7lE8n0WqhvuRiKccqYkdt/Y+jjkwz3l+Z3EQGJ
X-Gm-Gg: AYBFou1tH3VXs29/ekNdp0Q5xQPNIMsLEXUev76ams5SaFV2iqXON+jI9AjkJMBsviH
	v07Hexv3ofKIP4F+CDsE4lTWi05TdOMYoVBMK7QV8Zmrv08kORCx3NNfAOcua94jlDd3vlmqFMc
	cRxNHiDSEJ2W46EHUP0F9mhbC9xlXiZM6BblB+GZMTGxgfkkEOuRNYJGvpL6TPGpacjnNO6PEqW
	DOhFl3o81bTAMk8QEp4WnZvtDs5nHYrUcApd/dnGuj06+KzpxicU6eQS5lwtJfDY9i5ZMBuxvw+
	IwvzvMn9/sZMjER05qgO8dbe8Emvgaz9xd8Hm1VC7NUJkoXYM2zIhk030BdpiDlEDw==
X-Received: by 2002:aa7:c74f:0:b0:6b1:a517:5bce with SMTP id
 4fb4d7f45d1cf-6b20ab1840amr67168a12.16.1792017153710; Wed, 14 Oct 2026
 15:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-6-yosry@kernel.org>
 <CALMp9eSWazT=0tXKvGb9UNWBv62di33QgugQHOa+Bo2sq0qUCQ@mail.gmail.com>
 <CAO9r8zPPR9LMtcwhH=D8gJLjmC6800mJdyV+nKT83TnMti7wJw@mail.gmail.com>
 <CALMp9eTyzxwjKnWXem=dAGiwJsUsArssQTcQhg56HVd+js5pSQ@mail.gmail.com> <CAO9r8zNx-CUVeN8gfhnFxAUP9RBLnLV=eAFHhtW8FqTvhNEXFQ@mail.gmail.com>
In-Reply-To: <CAO9r8zNx-CUVeN8gfhnFxAUP9RBLnLV=eAFHhtW8FqTvhNEXFQ@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 15:32:20 -0700
X-Gm-Features: AclHuK-V-xCwiQ2XrkH5VqBxQlieInGerpdEGA-cb3DSm8FrVDltIDe8fdS4UGg
Message-ID: <CALMp9eSmXHbXx9Uov-Vx0=jrsmu-Tz0GYm6nPuaHWvZo3Bzxhg@mail.gmail.com>
Subject: Re: [PATCH v3 05/27] KVM: SVM: Add helpers to set/clear ASID flush in VMCB
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 3:25=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
> I would prefer vmcb_set_flush_asid() and vmcb_set_no_flush().

SGTM
