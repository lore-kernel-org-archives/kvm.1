Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89460322B77;
	Wed, 21 Jan 2026 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014088; cv=none; b=HE5XoVNXWDn27gQv9SiBL75YX5KJXDsP261f76lkZq7ByYBOKJtYncLBf0g6mEJ4igyuFYjM7pM/qFD2jWfmIF++mfmmQQEJqXDWC77trRnHRy/Q8XENJVKEYTPuDNFrcdEwPYVJ3BHPYbTSi8mqn24i0re2zK7R5O3KD4gsU5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014088; c=relaxed/simple;
	bh=4u8MFM6JIFNNUjADmEAcDRL08Ajc0pVx8qaYryk1QgY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bQAyPmfYllBwYAs+O6Kex5ZKHzxsxqdQQpOJUYohIJm/OVHSj0VmLDchWPr7iKTj7K7VznAztNb4+W2cKl50+3/G2bqt8ym2LcsUsPPKYAzNgGe+akatpGQCNiUTm83IBcAHoU4fbhoJHHDHu40BkqmBnQsdyp2UjpPHS192jTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Kc3AOx4G; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Kc3AOx4G"
Received: from smtpclient.apple (c-24-130-165-117.hsd1.ca.comcast.net [24.130.165.117])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60LGl3nH1893586
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 21 Jan 2026 08:47:03 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60LGl3nH1893586
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1769014024;
	bh=4u8MFM6JIFNNUjADmEAcDRL08Ajc0pVx8qaYryk1QgY=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=Kc3AOx4GxnuYJ4EvKCylkxnP0bBmtB2La1SoA5nqMdeaIhydYGARfd9C2JYeKXe7m
	 dKye8XObMJcmCXoAJpf1izgLsws5tLgIGeXQYgbLxgV6IGtjozoiAdEQQW5TPSfil1
	 SmDjIcogpRtF6CgrU4/EXF4NdYSoHoVF9CateIoqrHTajdulHXd3cTFGyZwi69zWdm
	 IdBPNvsiTa9CNzB55uHlbffLlTJhxCsa4T2vO8W9mCvTJt4xLesvXIjN4DO6OVjCfo
	 eYeOfjTSG8wp12Xfer9u1rern5jdYFlwqtCAtn0D8UsvhPnblzYCwd0UrzcrqU4jk6
	 QSPafE0+3xrgw==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v9 11/22] KVM: x86: Add a helper to detect if FRED is
 enabled for a vCPU
From: Xin Li <xin@zytor.com>
In-Reply-To: <9a628729-1b4f-4982-a3e6-b9269c91b3c2@linux.intel.com>
Date: Wed, 21 Jan 2026 08:46:53 -0800
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, andrew.cooper3@citrix.com,
        chao.gao@intel.com, hch@infradead.org, sohil.mehta@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <BEB86711-AE1D-4438-8278-229275493134@zytor.com>
References: <20251026201911.505204-1-xin@zytor.com>
 <20251026201911.505204-12-xin@zytor.com>
 <9a628729-1b4f-4982-a3e6-b9269c91b3c2@linux.intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)


> On Jan 21, 2026, at 12:05=E2=80=AFAM, Binbin Wu =
<binbin.wu@linux.intel.com> wrote:
>=20
>=20
> Not sure if it's OK with empty change log even though the patch is =
simple and
> the title has already described it.

IIRC, Sean changed it this way ;)

