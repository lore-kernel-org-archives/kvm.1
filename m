Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667278;
	b=HRxzHkfcF8XxmbV66+tFRasIbLFUiQARQIUFWRHS5B31KlX3L9nlNpcd6vpUp1cIFhvz
	 3KU/bHMViZfZROFFFjDtGGoIB9STyEaySuaGK5b5pYlDqpvbd41dWud2sugkYPAdk30ZT
	 TfRlsrVBX9dXkKo9MeedgQ7tucKRZaEOPwzdHeY4XCO3qtFsU7Y2SrPX4NfTKjJmbKd21
	 pfrpvg4lhZ0M0ovvHD2XvAHOLuzwELbEYaO9wXDOpPLMryBiExNCiF7YB89oATPgCEDuf
	 tVh5gDUTytGcC5V6TwMjje/NCK30+sZSqFMiki/lM9yTNivR4G90XTCHiKPMuF8suWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4CRzR+sjBX6VsuFNx9eyTn0HYGGxNmmsAqwo1yu/UIs=;
	b=hUSE7VQFJRAIHqRN38N+ohMuQL4FUIDLI3avDml2xHTiaSvm2K1BLpz273ugIsXDeLbP
	 etkk8+MDcCxnNHZZISHgdrFIDWAhrRK66oQeCk0ZfT1jZyQTyobGOMKmK0Hq8JEFumz1k
	 mmBdFQ9CataFloaKcsGFI0Wsl5sNr4QjLvmYYFO9i//4QyCvF1zCJf8Im7BTY/tK/djy9
	 YWF4b0aaCM5lg6yF1f652qmQ+Q7WFTnw6/LsnI2Pn7ZMXGUNelwdbq3OflGUfCmmeeUsx
	 mwi2VUru3C336d23AxUzuI6bNJZrawKU7Ze7MBYbitYRjjlZrCmToLiNEHNEWxmT3ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Htz2OgU4;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4AD606A326
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 00:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D4AD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Htz2OgU4
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so1741411a12.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 16:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793667277; x=1794272077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4CRzR+sjBX6VsuFNx9eyTn0HYGGxNmmsAqwo1yu/UIs=;
        b=Htz2OgU4aoVoKL8KpMSEspp6sNWAi9hXOOdM1nUPEy9kmXpP1/M/fDUBlD7MOhFKCt
         vd7mes6Qyx5ozUIcL1T5iIPjx72nLNEYaDp7npBaQFu90+PDEf21fo2hpJWNVLWuXiC7
         PbE41h9ViYg5FXRrpXN9m2MYGgrGana1/iF2MpsNGMX8Q4OyVEOEbQAwiQUB74RqB49O
         +aRggzz1znIelZFD5Ymfnt02XopRIlNVjPlflWrcmsoCbHqUDRoroC/3LcMZzY+Gjy0O
         suQX1K363W+v3+TI1ssS/pdEpyLVPcoc0passYoRJgD1VPiZ0Ww8NWbA8WhOKjg2ng0i
         OcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793667277; x=1794272077;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4CRzR+sjBX6VsuFNx9eyTn0HYGGxNmmsAqwo1yu/UIs=;
        b=EzXG5PriAEh8JflpIhm9GFA3+73PLPwoNkcj8A5WgzNpU0Nls1FrJTgpiSMVY5r/NY
         oPATdydT2WX93vregtw/tneqGVHmZzSnOGJCwd0kJXCOvL30DYh1+eB3y8wTGJn49Kd3
         1qLwRXgwdbIqoctQaZp91lGJV+cKPtctNKU0bmHdihf0qa8tAT77jSFONyb/vxpB7s6e
         VueLBax7bZIWOHp8dpov1hn1sTD9sCj39EbA00/jfjvcvivTLqzCk+i2xS6g8kvOkYP1
         nP4IcqgcmouHdpFtT0SsF6ydtC8eL6Cea99HJxTHHVuoSp0pKGMzew3TX6LF6zRNCLJ0
         R20A==
X-Forwarded-Encrypted: i=1; AKwUvBzfJKAUv78ruGW8ZhcdbmbdUlWiLyl50Am1apftHPhNRyUTjulhj90vyhRb6QVeckO10GI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xKoblsJVzLPpJ7vVfWYHUP/R7b+yctK0uUu+hFm/pe6JiFqc7
	tZFiTFPJTAQletUSou6ufn/N5m5yPFQc4waV3JnOT7vIxIOSire+yLW2jiwKY1Sx6Q5mC9LeMe/
	ILGagwm96
X-Gm-Gg: AYBFou0JFT2PX+Tfw6VacpGu7Jk33W/xT2PZlqa7if74rpD5G9vfWUlUHZfskks0F1Z
	R1qhQFCk+Vog/nKKk/hl74z7bcUUnQ1aV5OiliscT1YN5ay7bS/zBj15eG94sWQ9igYFg0n9gJI
	4gyjY30PXbaDZ8IeBQ60wUxmiJJELPWiqq0utOh15Zohf6+++Cytdtk8U8TdrOulxak/SY6w3yI
	iQrGgGx++kMSJp3+stEfmcvu+bbW43OkhhEAns6CiX1REkQujV7e/eafpp5LefUW9UIW/XtwCp3
	ur9F1WY6adwSW+TfflIfUnOh5Sj+2tpmDMZ2Y2VXConA7eyH/CCnhcEmFMiMdeagSXAtYxgGjA1
	7zBxVuv3x6d9TYINbeCsUjw0rrByahaES3fDZUaJH+k5wukNLyjpk6r0tmNqKHxZ8fAeqhgrKl6
	htyBXeVNV29J5qEmvhMh9WfcdJyiqUUQk4513IdPYSnexCLhZeh50IcjRxHxaqliy+uHW38/YVW
	pL2rLLWbzhUzBTmIq4z51tj2Zj2M9XYbq/3mvU4Yg57XRrmZPv5tS4+5/bCT8nHn2Gxd6ziVvQb
	vqfOVDZFG2oRVBxTtVBTRxKiTO+aiMqacGi6+wMjxmRUEZX3/A9q/J5hOrAzxD9UHw==
X-Received: by 2002:a17:90b:590d:b0:3ad:1da4:2ddf with SMTP id 98e67ed59e1d1-3ae8980ed29mr8608648a91.51.1793667277032;
        Mon, 02 Nov 2026 16:54:37 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85cb1bfdsm10260602a91.0.2026.11.02.16.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 16:54:36 -0800 (PST)
Date: Tue, 3 Nov 2026 00:54:32 +0000
From: David Matlack <dmatlack@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>,
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Vipin Sharma <vipinsh@google.com>, Alex Mastro <amastro@fb.com>,
	Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH v3 2/3] vfio: selftests: Add vfio_pci_find_mem_bar()
 helper
Message-ID: <aukwyHVkAXGEFI0E@google.com>
References: <20261102230445.3993629-1-almasrymina@google.com>
 <20261102230445.3993629-3-almasrymina@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102230445.3993629-3-almasrymina@google.com>

On 2026-11-02 11:04 PM, Mina Almasry wrote:
> Add vfio_pci_find_mem_bar() to libvfio to locate a BAR (or range within
> a BAR) of at least min_size bytes that behaves like ordinary memory and
> can be safely read and written without device-specific side effects.
> 
> Detection is backed by a table of known devices, starting with QEMU's
> pci-testdev (1b36:0005) BAR 2 when configured with membar=<size> and
> membar-backed=on.
> 
> Suggested-by: David Matlack <dmatlack@google.com>
> Cc: David Matlack <dmatlack@google.com>
> Cc: Matt Evans <matt@ozlabs.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: David Matlack <dmatlack@google.com>
