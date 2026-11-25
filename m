Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604226;
	b=DjylzgM8p6Qaz2xiCh4jXGJdaT9rS4ocKvXEksrRTx3eIXmaUAigV8wRRYHou/dkXrxN
	 MpkwRwNNJ0Apomv3xS/Y1ca+8Tgkm74cDKGnAs46bbl7pk5pDqk6V3QmhFzhzBqxOxEXL
	 OkvOWFSewrJ1Ou3chDnfNwug+azXZ6+pw0dyD3Ba8gcX/hHfnCm5dPTOLGDgDW5gT6+XA
	 SukfOrnfArRdixFtwBr96TrbKvkB7G9QhAmN+UE87DJvAQE97f7Lf8/98pFgIFFoknFBt
	 5LiJQFLrNBGlkM2WM/XL3z6JX1taLZxMIKRb9GHrm2Sg5QBde4svq5PGg4H6lYJprIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YkpRhjk7eWfHpjvog+/oou8N7W2d6opPsYzOd/5SwXg=;
	b=47MRVM/aDA+5XdW752+WWlOk1eFpSol/XpZIjnZoHTWDjUeiYKG6NubpHP/pcW0l6L9N
	 X/lsZucxdznzTKkNn7O7NEw9Oswf3BLLIsgq/oiwPlMqAFugjAra09cjRuphY/FzI551n
	 InCSo0WH2VnvFuZsRcXl1BYoc8/kwY0qHiOcS01mmgzca3Y4Sx7T6qglYaFiw8IW7M10y
	 IHkzGnZXUuE5BhTmryI0BCo6xGvDyzuTlFlQBpjY2VO4FFcjvqT63jYXFKATC6I0lfRu+
	 2XM9k8ndU5/q8Apmix44abjd1KuPtexWWigmO0G4KonMf8ROVrhjoAXwi5Jer6YaYaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=inxjbSRx;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526EB606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 10:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 526EB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=inxjbSRx
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so57573585e9.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 02:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795604224; x=1796209024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YkpRhjk7eWfHpjvog+/oou8N7W2d6opPsYzOd/5SwXg=;
        b=inxjbSRxBkBEmadFQq5hdl9sNOEVQrfBJYHdRaWCLAMOeYrMqAKi+DXO/rz3UTmdiR
         FLDIbv9km5FqWsegQcwGgJ5dEq3TcivcBsifEq3QpywIEF/jdt1kRdA3/aIVbveQym0o
         eHxo98Ib1Gn+q4ENtfwxQwY/DAGREEHPGS8OHerokrFGzkz4OhW+TeTIlDGkPRA0cdFx
         Yf067XKudsZ/JK3N8eXZfhX+8jChgX73JMookZH/0lV3x5TuDk7YhM69pzUWMp4pC110
         E8ZjurW6+sJY0Di1ysEEGeFngtzgyEenNP1qBsnY8IS5xeAeSJLBEPBSvumiErXJNH3O
         zX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604224; x=1796209024;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YkpRhjk7eWfHpjvog+/oou8N7W2d6opPsYzOd/5SwXg=;
        b=GtIKTNApHGlNkngrvwk7BtdlKeI+BmDzQuJpAdKnoTX8AGAA4B00lT1i/UxaZZik88
         aFqLGeEV/80Pf7bTtGrTLBC8odmhtZ22sCF6Ivb5cnsipwByfE/7I5BccFrIUKTMr43X
         zIjqBXMJx9WxwCfXJEhlO9XZjNmM7jlTQrYxLD6CoDm3N47OF4FdPHCV1axPoWKygt2Z
         TalLeEw+Enr4gOK7QN9l8Sc9dJ27v4fQJrlBRw4IPBr1JlnRhfFxqIkKMiZKo7iFaBJd
         j00z6pV26g4v0RXMdMKPz1/vXvtQdRGQ2ds2RM1aMRWXoBKN9wp+NIOltyKIk7tmZv2t
         SC3g==
X-Gm-Message-State: APuU4Z+rsK18UwueTqfAZgmCrA3ea6j41YXKczl4JX3GE3c3E7+NNWB2
	0ec75yHuphZHttLL/XAZwZtxUOYNdfEuFgrQr/m9Tazm+x1kotNuUiw8yquuhbPQ
X-Gm-Gg: AZFdTZcJ95v2+XQBgc5fiMTrlJVYT+nUeqTr3cRJWwaWmUqYZe8JvcEWsLCbkZ2cybd
	Oi3XvDkhMFd5qIdBtzflhAVLdlT02Xh2p66W6dkP+T8XaUvUvH/K6xZe0DBuumDvB2R6mg6O9Yj
	JUYzpRaMxkVqoSwfX0IWYb3zbK3zyNMpYj+QXa9/GDfaQ/M/FddazIqayr9Tlr+nj5bYg4roFOF
	eiOLV9shjsK2rX/vmtXzBYaxQmXwJ1Cs0tabJzJAXiWtl/umMll1hA77RATpGVzG6QJ+5KI5MhB
	S4pfPqKCp/SsgLir4xT/jKswjXa0IdDhigEvJfCwKeRN1rO7VCRm52FBJGf2ojtCptFa2KxB/L6
	3PhlORlpF7uS8jBdTa8AkqPBtaDOoknDJ4aqMICw/XYBRfA1R8Me6H1aXOPDnsIMDPxnDau3iwD
	8Ai5U02+u6wlouyAhUOHvtRzBQd7lrG25hn4W311YPHa6Y1POTsWpke9NFD8z7FONgtB/VCKi+3
	Ou/mfRqEEHCatf6gBy3ggbNsuS7t52NEZ+D+nDBAiDQzPnvEe8jQqfidk2MgcbUMZyh25XY0W+K
	OzpyzIW2HAUk/9sH/v/PKoL4/EZrLtWZMkg=
X-Received: by 2002:a05:600c:c168:b0:4bb:81b2:c801 with SMTP id 5b1f17b1804b1-4bb889238f1mr344249025e9.20.1795604223717;
        Wed, 25 Nov 2026 02:57:03 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067a0e6sm234438035e9.4.2026.11.25.02.57.02
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 02:57:03 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <05f1b73e-2bca-46b2-b54e-ea8023129c37@xen.org>
Date: Wed, 25 Nov 2026 10:57:02 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/21] hw/xen: Fix partial request header handling in
 emulated XenStore
To: kvm@vger.kernel.org
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-2-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-2-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> When a XenStore request header is only partially received, QEMU copies
> XENSTORE_HEADER_SIZE bytes instead of only the remaining header bytes.
> 
> Fix the length calculation to copy only the missing part of the header.
> 
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3644
> Fixes: f3341e7b915 ("hw/xen: Add basic ring handling to xenstore")
> Fixes: CVE-2026-61403
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_xenstore.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
