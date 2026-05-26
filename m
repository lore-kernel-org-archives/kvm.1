Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6383D1A81
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839393; cv=pass; b=has0C9gFeFWSIAENw3IPrdD1WKggVp2Pvjul65mqdZlkiqtoS/MHwN3kCjl+lBOx8dGlf5nqG3PV7nJq+vYBi2pHKjKFGucffbVDqxsuPc/inDg/1wYEIsfJIgKcEA9K1uWmgsbSkRw3GhxHIF6cbUDO0TvBl0MhWIoODXZWBq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839393; c=relaxed/simple;
	bh=UFTUqui+lyDEpkII00aPHz64gTpTCUqug24pFaLMXHE=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=XKJxqZSsEO0uH1hmVUpVbQGNfwg/htViamauGXbXxr5CToxoOIzfw6V0xBTw/l//JEazZVuUBZ+q6och/vCy9unAKJlkfItJ58cgH10SJPMYGWSr65lKgsjjEtJbiujYqEYlAmBKv275Zl2tWbWqmUtGXMXyWgLwsgcTNaTxOUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUeSs95y; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUeSs95y"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13643f6d1a9so2921980c88.0
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779839387; cv=none;
        d=google.com; s=arc-20240605;
        b=Y7PsV7d3/mvd8ICCJLHiyowFFI0gjqRlNLwskRvfyc8OBjhTmsLBo31RJIDmI3CXA+
         yfH1+8o9nSb31VsH25Zo6OKucpQ+bzcNQSI8e7DNKp3hHPdx2nq4OR4GxJ4U6U4NStmM
         sUs5rKPaLc0uFC93nXf+0K0LQ3g0Gj+4X8d3Vz0HREC+9uLPDshU0EZdLPruUtI1c3JS
         il0SIF7ZQpP+y841i7mh87EIcwjL7GC5CHEJXIGTYL7fJgSBhbYnqkFiRvHdBMTKEo1Q
         vMrcAtOpM5jOX6E6hjQ4h5ph0o9bDt4CGbnqAFFY7Npq7vGK+hdKnItN+tHDf+rGt/RN
         0lFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=UFTUqui+lyDEpkII00aPHz64gTpTCUqug24pFaLMXHE=;
        fh=QoXqclTgHxHxS8QO18knkkxlqXrD2gIafxBmEMk0u10=;
        b=bASJFvtFL4SRpfO+HXv3nv35X6h94LQ9UXZ8OQla1vcUzEKsMOcA6g/FpSkVBkUZKa
         uamTuzuOkCeZZCuePjvZGMMBx66vvFU60H8XWg+uY3wdcss/jwjNpINCu+TjUJ1CMasA
         MthwUaOruKKGMFwWb/V0+Yys+ACVKdSAopwTG7d/5RS9CHCFO2pjhM+UOerkZumnlyh/
         /62RtPhAyYPddH6VUId1ogW7Q1b+lt3hyWYnxAxC79k/F4Dlh3NSayzI8s5KzCnUQCC9
         58NY/fRr1OFOIbWzE+hn2w4/SFmH8Dw4k86iXCrXDEJDR8d1/oM9eDc6PXa37a+k4qX+
         2H3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779839387; x=1780444187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UFTUqui+lyDEpkII00aPHz64gTpTCUqug24pFaLMXHE=;
        b=XUeSs95yyIVT8QtPQNFPFhIc+guWDmUJoa4VDHnMjovXMse78PYOK4p2mGIXWx4HXp
         3+FZeHpqtmToRlyHda07EdZMC9FtFZE2lDBK7h+y8S3PuLYoapb+l1G3eyAG7bSVok5V
         hI1Da1izjr2hlMl+0gjQKBHQvei/IbHOCZre7PIAL9BFf2sR+bE6lUERiuP+VUP2mT+K
         NYpxkgUKernWth73BTqhVSdmVv5OrCDE62JfwqVJ4e+WsyMbOVSB82NApgDYapPwLffB
         RcEOa9U4wGUjnPnEMbXLgUwHwmVahK6Bu2+zR4TIa97Jt2iB0MfsBzm4iOgsCbKyz9bl
         07Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779839387; x=1780444187;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFTUqui+lyDEpkII00aPHz64gTpTCUqug24pFaLMXHE=;
        b=fN79VTOyofFF7l/MjnG4o/A3g7WQvTv0L9aYWy/UpQZwmPSIKCNoguknB2F9PFof2u
         4ivzEQfqiHErmNxl8J/k0pAF7kbI+MlpuFe0MEYm9Fu3e45k1vSE7r86eRdJ323ikvYh
         wzTi6vkMRlBkvYNlEpCKE52HF1hqyjEArR33/YEXqZrLecFiKUL0NxMR8YVN6QqKYgEh
         SA+a9RCF2ULxEAd99L+YXxF+TbrdSFmxIyT8+qwH0Dfm/0FZQ2QTO+Qb8J6V/FRQj5T0
         Rdpq/qLRFz2c6g0JFYBVI/EwE5hGZDn7bQ/AQVVJmnzzU5YwkqiuukbLKLf6t6nZQfdK
         K0NA==
X-Forwarded-Encrypted: i=1; AFNElJ89nuxYfTxTmQM1FmZaYltCFxl5FnBuE5Q9v+sc6Ek2jhjWglnG7GCsO2K5dPqqGyQf0d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYqv1zETQoWLX217pNWF14RYpQjA1ZjgYLw+1h/S7wfWuD0KLT
	UVCVSYtNKX85ChbZGKoRdB9llgiVho5EHya4EqM2tUw+UNi0ZChi3etrjeiwmzLF0pYiD1+rqxT
	JANcOm+1KyDzDgbkTe1/5nFCFvrb0+AZ0xIsVMjB3G8/HYHXeyy0FFxok
X-Gm-Gg: Acq92OEeOHzjwGT4lX35UHRzPaWf6uSX4ZT86PyDeyMPGcch2B6wYDvtI2Yvtq9q1Ba
	euvHgC6aIRblJRlXDhTE1i8WJVFDbHqVdLgfLGQ7KCYHF8slpgy3fNtdxNvMtPw3i827u69x7bb
	d8QGML0ewLV/tw3rNpmFQhmXbSDqPOKe5dzgzeqDfqeTxQH27NxUSvNZFETjcmDqJOc5D2FUB/9
	HsHVexx8aIbwnusId+zd4DxZ6u+BZnppdFhQopGzhkizH2gHvhAS4AVdjqwbMvI/InzLL3axaEA
	5/de5Kr/nfnoyfzBs4Uw3OwQscnYyGQYmvCFZ3ln0LyTmoknvUyH9JuwXwObhDdM0w2RlVtPF9R
	3lUje
X-Received: by 2002:a05:7022:ea5b:b0:136:8bdd:3f66 with SMTP id
 a92af1059eb24-1368bdd40d4mr3880334c88.5.1779839386030; Tue, 26 May 2026
 16:49:46 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 May 2026 16:49:45 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 May 2026 16:49:45 -0700
From: Ackerley Tng <ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 May 2026 16:49:45 -0700
X-Gm-Features: AVHnY4Jg_aMxqxLmYUYtrQZjJQlu067bf5olggbfoUjTDaktgramXq6wUUS1BnQ
Message-ID: <CAEvNRgHLVPcJenAej85Q31YrM0tCnTpibDsEBdZmaTpf9QaTBA@mail.gmail.com>
Subject: [Invitation] bi-weekly guest_memfd upstream call on 2026-05-28
To: linux-coco@lists.linux.dev, linux-mm@kvack.org, kvm@vger.kernel.org
Cc: david@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Our next guest_memfd upstream call is scheduled for Thursday, 2026-05-28
at 8:00 - 9:00am (GMT-07:00) Pacific Time - Vancouver.

We'll be using the following Google meet:
http://meet.google.com/wxp-wtju-jzw

In this meeting, we'll Tarun talk about guest_memfd preservation for
LiveUpdate.

We also have one question regarding virtio-mem and CoCo forwarded from
David.

The meeting notes can be found at [1], where we also link recordings and
collect current guest_memfd upstream proposals. If you want an google
calendar invitation that also covers all future meetings, just write
Ackerley or David a mail.

To put something to discuss onto the agenda, reply to this mail or add
them to the "Topics/questions for next meeting(s)" section in the
meeting notes as a comment.

[1] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?usp=sharing

Ackerley
